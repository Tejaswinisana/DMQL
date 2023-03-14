from flask import Flask,render_template,request,redirect,url_for,flash
import psycopg2
import psycopg2.extras

app= Flask(__name__)
app.secret_key = "cairocoders-ednalan"

DB_HOST = "localhost"
DB_NAME = "Shopcart"
DB_USER = "postgres" 
DB_PASS = "1234"

conn = psycopg2.connect(dbname= DB_NAME, user = DB_USER,password =DB_PASS, host= DB_HOST)

@app.route('/')
def Index():
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    s= "select * from product"
    cur.execute(s)
    list_products = cur.fetchall()
    return render_template('index.html',list_products=list_products)
@app.route('/Customerview')
def view_Customer():
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    s= "select * from customers"
    cur.execute(s)
    list_customers = cur.fetchall()
    return render_template('customers.html',list_customers=list_customers)
@app.route('/shipping')
def view_Shippingfla():
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    s= "select * from shipping_details"
    cur.execute(s)
    list_customers = cur.fetchall()
    return render_template('shipping.html',list_customers=list_customers)





@app.route('/delete/<string:id>', methods = ['POST','GET'])
def delete_product(id):
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    print(cur.mogrify("DELETE FROM product WHERE prod_id = '{0}'".format(id)))
    cur.execute("DELETE FROM product WHERE prod_id = '{0}'".format(id))
    
    conn.commit()
    flash('Product Removed Successfully')
    return Index()

@app.route('/add_product', methods=['POST'])
def add_product():
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    if request.method == 'POST':
        prod_cat = request.form['prod_cat']
        prod_sub_cat = request.form['prod_sub_cat']
        prod_id = request.form['prod_id']
        prod_base_margin = request.form['prod_base_margin']
        cur.execute("INSERT INTO product(product_category, product_sub_category, prod_id,product_base_margin) VALUES (%s,%s,%s,%s)", (prod_cat, prod_sub_cat, prod_id,prod_base_margin))
        conn.commit()
        flash('Product Added successfully')
        return Index()
@app.route('/edit/<id>', methods = ['POST', 'GET'])
def get_product(id):
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    print(id)
   
    cur.execute("SELECT * FROM product WHERE prod_id = '{0}'".format(id))
    data = cur.fetchall()
    cur.close()
    return render_template('edit.html', product = data[0])
@app.route('/update/<id>', methods=['POST'])
def update_product(id):
    if request.method == 'POST':
        prod_cat = request.form['prod_cat']
        prod_sub_cat = request.form['prod_sub_cat']
        prod_base_margin = request.form['prod_base_margin']
    

       
         
        cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        cur.execute("""
            UPDATE product
            SET product_category = %s,
                product_sub_category = %s,
                product_base_margin = %s

            WHERE prod_id = %s
        """, (prod_cat, prod_sub_cat,prod_base_margin, id))
    
        conn.commit()
        return Index()
