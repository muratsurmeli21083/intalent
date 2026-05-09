import pandas as pd
import numpy as np

# Creating a synthetic dataset since SSL verification failed for the API
data = {
    'age': [52, 53, 44, 52, 41, 58, 56, 44, 52, 57, 54, 48, 49, 64, 58, 50, 58, 66, 43, 67],
    'sex': [1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0, 1, 0, 1, 1],
    'cp': [0, 0, 0, 0, 1, 0, 1, 0, 3, 2, 0, 2, 1, 3, 3, 2, 2, 3, 0, 0],
    'trestbps': [125, 140, 120, 128, 110, 100, 140, 120, 172, 150, 124, 130, 130, 110, 150, 120, 140, 150, 150, 142],
    'chol': [212, 203, 263, 204, 172, 248, 294, 263, 199, 168, 266, 275, 266, 211, 283, 219, 197, 226, 247, 212],
    'fbs': [0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1],
    'num': [0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 1, 0, 1, 1, 0, 0, 1] # Target: 0 (No), 1 (Yes)
}

df = pd.DataFrame(data)

print("--- Data Info ---")
print(df.info())
print("\n--- First 5 Rows ---")
print(df.head())

# Basic analysis: Average cholesterol of people with vs without heart disease
avg_chol = df.groupby('num')['chol'].mean()
print("\n--- Average Cholesterol by Heart Disease Status (0=No, 1=Yes) ---")
print(avg_chol)

# Simple Preprocessing using Scikit-Learn
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score

X = df.drop('num', axis=1)
y = df['num']

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train)
X_test_scaled = scaler.transform(X_test)

# Train a simple Logistic Regression model
model = LogisticRegression()
model.fit(X_train_scaled, y_train)

# Predict and evaluate
y_pred = model.predict(X_test_scaled)
accuracy = accuracy_score(y_test, y_pred)
print(f"\n--- Model Accuracy: {accuracy * 100:.2f}% ---")
