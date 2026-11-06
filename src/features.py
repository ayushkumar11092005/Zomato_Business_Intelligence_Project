import sqlite3
import pandas as pd
import os

def engineer_features():
    db_path = '../data/zomato_project.db'
    conn = sqlite3.connect(db_path)
    
    def get_clean_df(table_name):
        try:
            df = pd.read_sql(f"SELECT * FROM {table_name}", conn)
            df.columns = [c.strip().lower().replace(' ', '_').replace('-', '_') for c in df.columns]
            return df
        except Exception as e:
            return pd.DataFrame()

    df_orders = get_clean_df('orders')
    df_restaurants = get_clean_df('restaurants')
    df_partners = get_clean_df('delivery_partners')
    df_customers = get_clean_df('customers')

    os.makedirs('../data/processed', exist_ok=True)

    if not df_orders.empty:
        df_delivery = df_orders.copy()
        if not df_restaurants.empty and 'restaurantid' in df_delivery.columns:
            df_delivery = df_delivery.merge(df_restaurants, on='restaurantid', how='left', suffixes=('', '_rest'))
        if not df_partners.empty and 'deliverypartnerid' in df_delivery.columns:
            df_delivery = df_delivery.merge(df_partners, on='deliverypartnerid', how='left', suffixes=('', '_partner'))
            
        df_delivery.to_csv('../data/processed/delivery_features.csv', index=False)
        print("Delivery features saved.")

    # Churn features ke liye safe fallback logic
    if not df_orders.empty:
        if df_customers.empty:
            # Agar customers table nahi hai toh orders se hi customer_id bana lo
            df_churn = df_orders[['customerid']].drop_duplicates().copy()
        else:
            df_churn = df_customers.copy()

        cust_col = 'customerid' if 'customerid' in df_churn.columns else df_churn.columns[0]
        
        order_agg = df_orders.groupby(cust_col).agg(
            total_orders=('orderid', 'count'),
            total_spent=('finalamount', 'sum') if 'finalamount' in df_orders.columns else ('orderid', 'count')
        ).reset_index()
        
        df_churn = df_churn.merge(order_agg, on=cust_col, how='left').fillna(0)
        df_churn.to_csv('../data/processed/churn_features.csv', index=False)
        print("Churn features saved successfully.")

    conn.close()

if __name__ == '__main__':
    engineer_features()