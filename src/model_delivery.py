import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_squared_error, r2_score
import joblib
import os

def train_delivery_model():
    file_path = '../data/processed/delivery_features.csv'
    if not os.path.exists(file_path):
        print("Error: delivery_features.csv nahi mila.")
        return

    df = pd.read_csv(file_path)
    print("Available columns:", df.columns.tolist())
    
    # Sahi column names jo terminal output mein dikh rahe hain
    features = [col for col in ['foodcost', 'deliveryfee', 'finalamount'] if col in df.columns]
    target = 'deliverytimeminutes'
    
    if target not in df.columns:
        print(f"Error: Target column '{target}' dataframe mein nahi hai!")
        return

    if not features:
        print("Error: Koi bhi valid feature column nahi mila!")
        return

    print(f"Using features: {features} and target: {target}")
    
    df = df.dropna(subset=features + [target])
    X = df[features]
    y = df[target]
    
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
    model = RandomForestRegressor(n_estimators=100, random_state=42)
    model.fit(X_train, y_train)
    
    y_pred = model.predict(X_test)
    rmse = np.sqrt(mean_squared_error(y_test, y_pred))
    r2 = r2_score(y_test, y_pred)
    
    print(f"Delivery Model Training Completed! RMSE: {rmse:.2f}, R2: {r2:.2f}")
    
    os.makedirs('../models', exist_ok=True)
    joblib.dump(model, '../models/delivery_model.pkl')
    print("Model saved in ../models/delivery_model.pkl")

if __name__ == '__main__':
    train_delivery_model()