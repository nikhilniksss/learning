import streamlit as st
import pandas as pd
import numpy as np
import pickle
from sklearn.preprocessing import StandardScaler,LabelEncoder


# function to load the model

def load_model():
    with open ("/Users/nick_mac/Desktop/FSDS/student_performance_app/student_lr_model.pkl",'rb') as file:
        model, scaler, le = pickle.load(file)
    return model,scaler,le


# function to perform scaler and label encoding

def preprocessing_input(data,scaler,le):
    data['Extracurricular Activities'] = le.transform([data['Extracurricular Activities']])[0]
    df = pd.DataFrame([data])
    df_transformed = scaler.transform(df)
    return df_transformed


# function to predit the data

def predict_data(data):
    model, scaler, le = load_model()
    processed_data = preprocessing_input(data, scaler, le)
    prediction = model.predict(processed_data)
    return prediction


def main():

    st.title("Student Performance Predictor")
    st.write("Enter your data to get your performance predictor")

    hours_studied = st.number_input("Hours Studied",min_value=1,max_value=10,value=5)
    previous_score = st.number_input("Previous Score",min_value=40,max_value=100,value=70)
    extra_activities = st.selectbox("Extra Activities",["Yes","No"])
    sleep_hour = st.number_input("Sleeping Hours",min_value=4,max_value=10,value=7)
    paper_solved = st.number_input("Question Paper Solved",min_value=0,max_value=100,value=0)

    if st.button("Predict"):
        user_data = {
            "Hours Studied":hours_studied,
            "Previous Scores":previous_score,
            "Extracurricular Activities":extra_activities,
            "Sleep Hours":sleep_hour,
            "Sample Question Papers Practiced":paper_solved
        }

        prediction = predict_data(user_data)
        st.success(f"Your prediction result is {prediction}")

if __name__ == "__main__":
    main()