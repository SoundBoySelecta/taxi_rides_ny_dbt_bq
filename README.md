DBT - Data Built Tool
Dbt is a transformation layer tool used mostly within Data ware houses (DWH)
with the focus on SQL based transformations.
Use cases: With the evolution of data engineering practices, we focus on ELT versus,
ETL. By separating compute and storage, we can use compute 
resources to extract data from disparate systems and use a seperate storage scheme in this case a DwH.
DBT is analytics focused, the closer we get to analytics end points like dashboarding and viz, there is value 
in smaller more valid data, smaller in the sense of speed for efficient querying and cleaned data.
Why do we need to separate compute and storage?
Scalability: We can scale each at differently, without impacting each other.
Flexibity: Different configurations and techs for each. Non dependant.
Cost-Effectiveness: We dont need a one size fit all scenario, so we can customize each so we dont over provision and under
utilize.
Performance Isolation: Independant components  = independant performance
Data durability and Avialibility: Lower risk of data lose
