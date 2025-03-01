SELECT campaign_name,
ROUND(SUM(base_price * `quantity_sold(before_promo)`) / 1000000,1) AS total_rev_before_promo,
ROUND(SUM(CASE
       WHEN promo_type = 'BOGOF' THEN base_price * .5 * (`quantity_sold(after_promo)` * 2)
       WHEN promo_type = '500 Cashback' THEN base_price - 500 * (`quantity_sold(after_promo)`)
       WHEN promo_type = '25% OFF' THEN base_price * .75 * (`quantity_sold(after_promo)`)
       WHEN promo_type = '33% OFF' THEN base_price * .67 * (`quantity_sold(after_promo)`)
       WHEN promo_type = '50% OFF' THEN base_price * .50 * (`quantity_sold(after_promo)`)
       END) / 1000000 , 1 ) AS total_rev_after_promo
FROM fact_events
JOIN dim_campaigns USING (campaign_id)       
GROUP BY campaign_name;

    