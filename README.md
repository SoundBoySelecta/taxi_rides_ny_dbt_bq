DBT - Data Built Tool
Dbt is a transformation layer tool used mostly within Data ware houses (DWH) focusing on SQL based transformations.
Use cases: Data engineering practices have evolved, we focus on ELT versus, ETL. Raw data is extracted from 
sources and loaded into a data lake then transformed in a DWH. DBT is analytics focused, the closer the data gets to 
the end users analytics there is value in smaller more valid data, smaller in the sense for speed of efficient querying 
returning results faster and valid as in cleaned data. ETL/ELT still corresponds to (bronze, silver, gold) 
medallion architecture, ELT also takes advantage of seperating compute and storage, we can use compute 
resources to extract data from disparate systems and use a seperate storage scheme in this case a data lake.

Why do we need to separate compute and storage?
Scalability: We can scale each at differently, without impacting each other.
Flexibity: Different configurations and techs for each. Non dependant.
Cost-Effectiveness: We dont need a one size fit all scenario, so we can customize each so we dont over provision and under
utilize.
Performance Isolation: Independant components  = independant components = independant performance. 
Containerized orchestrators like K8 can spawn new compute instances if one crashes. Clou data storage and lakes
are fault tolerant by nature. 
Data durability and Avialibility: Lower risk of data loss and downtime, if compute component goes down, the storage
layer is still available and vise versa. Cloud systems replicate and distribute data across different region.
Data Portability: We can manage and migrate data between systems as needed.
Specialized workloads: catered solutions each component, can use object storage for unstructured and relation databases 
for structured, and use general purpose compute for processing.


