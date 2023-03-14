# Data Source:
https://www.kaggle.com/datasets/tanyadayanand/online-shopping?select=shipping.csv

# Database Creation:
Create the database using pgAdmin

# Relational Schema creation:
Create the required tables inside the database that we have created in the above step using Create.sql

Note: Execute the file as it is, we have taken care of the referential dependencies while creating the file.


# Data Load:
Loading data could be done in two ways:
    1. execute load.sql file 
            Or
    2. use CSV folder and import the data into the created tables.

# Installation of web application:
Once you are done with the above two step, follow the below steps to run the application:

step 1: 
> pip install flask
> pip install psycopg2

step 2: 
On the command line 
> flask run 
Note: Server runs on localhost 5000 port if you want to exit use ctrl+c 

#### Make sure to change the db password and user name according to your local postgresql passwords. ( edit app.py following four variables )

DB_HOST = "localhost"
DB_NAME = "Shoppingcart"
DB_USER = "postgres"
DB_PASS = "1234"



