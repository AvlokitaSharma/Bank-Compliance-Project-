import pandas as pd
import numpy as np

# Sample data creation
data = {
    "Transaction_ID": np.arange(1, 501),
    "Date": pd.date_range(start="2023-01-01", periods=500, freq='D'),
    "Account_Type": np.random.choice(["Savings", "Checking"], 500),
    "Amount": np.random.uniform(100, 1000, 500).round(2),
    "Compliance_Flag": np.random.choice([0, 1], 500, p=[0.1, 0.9])
}

# Create a DataFrame
df = pd.DataFrame(data)

# Define a function to check compliance for each transaction
def check_compliance(row):
    if row['Amount'] >= 500 and row['Account_Type'] == 'Checking':
        return 1
    return 0

# Apply the compliance check function
df['Calculated_Compliance'] = df.apply(check_compliance, axis=1)

# Checking for discrepancies
df['Compliance_Mismatch'] = np.where(df['Compliance_Flag'] != df['Calculated_Compliance'], 1, 0)

# Output a summary of the compliance check
compliance_summary = df['Compliance_Mismatch'].value_counts()

# Excel operations
# For demonstration, let's assume we export this DataFrame to Excel and use Excel for further manipulation
excel_file_path = '/mnt/data/Compliance_Report.xlsx'
df.to_excel(excel_file_path, index=False)

# Sample code to simulate Excel operations using Pandas (since we cannot run Excel in this environment)
# We'll perform a groupby operation that could be akin to a PivotTable in Excel
pivot_table_simulation = df.groupby(['Account_Type', 'Compliance_Flag']).agg({
    'Amount': ['mean', 'sum'],
    'Transaction_ID': 'count'
})
