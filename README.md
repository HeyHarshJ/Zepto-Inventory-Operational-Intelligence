# 🚀 Zepto Inventory & Operational Intelligence Dashboard

## **Project Overview**
This project provides a deep-dive analysis into the inventory health and logistics distribution of **Zepto**, India's leading 10-minute delivery service. Using a public snapshot of their product catalog (3.2K+ SKUs), I built an end-to-end data pipeline—from raw data cleaning in **SQL** to an executive **Power BI** dashboard.

The goal was to identify operational bottlenecks, such as high-value stock risk and logistics load distribution, to optimize quick-commerce delivery efficiency.

---

## **📂 Dataset Details**
* **Source:** Zepto Public Inventory Snapshot
* **Size:** 3,200+ unique SKUs across 14 categories.
* **Key Fields:** Category, MRP, Discounted Selling Price, Available Quantity, Weight (gms), and Stock Status.

---

## **🛠️ The Technical Workflow**

### **1. SQL Data Analysis & Cleaning**
I used PostgreSQL to transform the raw CSV data into a business-ready format.

* **Data Cleaning:** Handled null values and converted pricing from paise to Indian Rupees (INR) for accurate valuation.
* **Business Logic Queries:**
    * **Financial Risk:** Identified the top 10 highest-value products sitting in the warehouse.
    * **Revenue Projection:** Calculated estimated revenue per category using `(discountedSellingPrice * availableQuantity)`.
    * **Inventory Auditing:** Isolated products with high MRP that are currently out of stock to highlight lost revenue opportunities.

### **2. Logistics Categorization**
To optimize Zepto's delivery fleet, I categorized products based on weight (using CASE statements in SQL):
* **Low Weight:** < 1000g (optimized for standard bike delivery)
* **Medium Weight:** 1kg - 5kg
* **Bulk/Heavy:** > 5kg (items requiring specialized handling)

---

## **📊 Power BI Dashboard Highlights**
The final dashboard was built on a custom **1580x1120** high-density canvas designed for executive oversight.

* **Executive KPIs:** Real-time tracking of Active SKUs, Total Stock Value (₹2,243K), Avg. Discount (7.90%), and a critical **12.14% Out-of-Stock Rate**.
* **Logistics Treemap:** Visualizes the "Logistics Mix" across 14 categories, revealing that *Cooking Essentials* represent the heaviest warehouse load.
* **Revenue Analysis:** A clustered bar chart showing category-wise financial exposure.
* **Stock Health Donut:** A quick visual of "In-Stock" vs "Out-of-Stock" ratios.
* **Pricing Benchmarks:** A summary card identifying the inventory's price range (₹9 starting price up to ₹1,399 premium items).

---

## **💡 Key Insights**
1.  **Supply Chain Gap:** 12.14% of the catalog is currently out of stock, indicating potential revenue leakage in high-demand categories.
2.  **Logistics Load:** *Cooking Essentials* and *Munchies* account for over **42.42%** of the warehouse weight, suggesting Zepto should prioritize heavy-vehicle routing for these zones.
3.  **Revenue Concentration:** Top 10 High-Value SKUs represent a significant portion of capital exposure, requiring strict inventory turnover monitoring.

---

## **🚀 How to Run**
* **SQL:** Run the scripts in the `Zepto_SQL_data_analysis.sql` file to clean and transform the raw data.
* **Power BI:** Open the `Zepto_Inventory_Dashboard.pbix` file to interact with the visual report.
