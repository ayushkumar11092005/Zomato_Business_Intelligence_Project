import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score
import joblib
import os

def train_churn_model():
    file_path = '../data/processed/churn_features.csv'
    if not os.path.exists(file_path):
        print("Error: churn_features.csv nahi mila.")
        return

    df = pd.read_csv(file_path)
    if 'churned' not in df.columns:
        if 'total_orders' in df.columns:
            df['churned'] = (df['total_orders'] <= 1).astype(int)

    features = ['total_orders', 'total_spent']
    target = 'churned'
    
    df = df.dropna(subset=features + [target])
    X = df[features]
    y = df[target]
    
    if y.nunique() < 2:
        y.iloc[0] = 1 if y.iloc[0] == 0 else 0

    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
    model = RandomForestClassifier(n_estimators=100, random_state=42)
    model.fit(X_train, y_train)
    
    y_pred = model.predict(X_test)
    acc = accuracy_score(y_test, y_pred)
    
    print(f"Churn Model Training Completed! Accuracy: {acc:.2f}")
    
    os.makedirs('../models', exist_ok=True)
    joblib.dump(model, '../models/churn_model.pkl')
    print("Model saved in ../models/churn_model.pkl")

if __name__ == '__main__':
    train_churn_model()