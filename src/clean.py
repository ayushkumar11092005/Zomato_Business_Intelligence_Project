import os
import pandas as pd

def clean_data():
    raw_dir = '../data/raw'
    cleaned_dir = '../data/cleaned'
    
    os.makedirs(cleaned_dir, exist_ok=True)
    
    if not os.path.exists(raw_dir):
        print(f"Error: {raw_dir} फोल्डर नहीं मिला!")
        return

    file_mapping = {
        'cities (1).csv': 'cities.csv',
        'customer_feedback (1).csv': 'customer_feedback.csv',
        'customers (2).csv': 'customers.csv',
        'delivery_partners.csv': 'delivery_partners.csv',
        'menu.csv': 'menu.csv',
        'order_items.csv': 'order_items.csv',
        'orders.csv': 'orders.csv',
        'payments (1).csv': 'payments.csv',
        'promotions.csv': 'promotions.csv',
        'restaurants.csv': 'restaurants.csv',
        'traffic.csv': 'traffic.csv',
        'weather.csv': 'weather.csv'
    }

    success_count = 0

    for raw_name, clean_name in file_mapping.items():
        raw_path = os.path.join(raw_dir, raw_name)
        cleaned_path = os.path.join(cleaned_dir, clean_name)
        
        if os.path.exists(raw_path):
            try:
                df = pd.read_csv(raw_path)
                
                # कॉलम के नामों को स्टैंडर्ड करना
                df.columns = [c.strip().lower().replace(' ', '_').replace('-', '_') for c in df.columns]
                
                # मिसिंग वैल्यूज को संभालना (New Pandas syntax)
                df = df.ffill().bfill().fillna(0)
                
                # क्लीन की गई फाइल को सेव करना
                df.to_csv(cleaned_path, index=False)
                print(f"Successfully cleaned and saved: {clean_name}")
                success_count += 1
            except Exception as e:
                print(f"Error processing {raw_name}: {e}")
        else:
            print(f"Warning: Raw file नहीं मिली -> {raw_name}")

    print(f"\nडेटा क्लीनिंग पूरी हुई! कुल {success_count}/12 फाइलें सफलतापूर्वक क्लीन हो गई हैं।")

if __name__ == '__main__':
    clean_data()