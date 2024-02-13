-- */To determine the customer retention
with cohort as (
    select
        "customerId",
        date_trunc('month', min("orderDate"::date)) as first_purchase_month
    from
        {{ ref('stgOrders') }} o
    group by
        1
),
retention_data as (
    select
        c."customerId",
        date_trunc('month', o."orderDate"::date) as order_month,
        count(distinct o."orderId") as repeat_purchases
    from
        {{ ref('stgOrders') }} o
    join
        cohort c on o."customerId" = c."customerId"
    group by
        1, 2
)
select
    date_trunc('month', first_purchase_month) as cohort_month,
    count(distinct r."customerId") as total_customers,
    count(distinct case when repeat_purchases > 0 then r."customerId" end) as retained_customers,
    (count(distinct case when repeat_purchases > 0 then r."customerId" end)::float / count(distinct r."customerId")::float) * 100 as retention_rate
from
	cohort c
left join
    retention_data r on c."customerId" = r."customerId" and c.first_purchase_month = r.order_month
group by
    cohort_month
order by
    cohort_month