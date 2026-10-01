import streamlit as st
import pandas as pd


st.set_page_config(
    page_title='Pizza sales dashboard',
    page_icon=':pizza:',
    layout = 'wide'
)

df = pd.read_csv('pizza_sales.csv')


st.sidebar.header('Filter Data here')

ps = pizz_size = st.sidebar.multiselect(
    'Select Data',
    options= df['pizza_size'].unique(),
    default= df['pizza_size'].unique()
)

df_selection = df.query(
    "pizza_size == @ps"
)

total_revenue = df_selection['total_price'].sum()

st.subheader(f'{total_revenue}')