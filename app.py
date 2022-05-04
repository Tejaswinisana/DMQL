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
@app.route('/delete/<string:id>', methods = ['POST','GET'])
def delete_student(id):
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    print(cur.mogrify("DELETE FROM product WHERE prod_id = '{0}'".format(id)))
    cur.execute("DELETE FROM product WHERE prod_id = '{0}'".format(id))
    
    conn.commit()
    flash('Product Removed Successfully')
    return Index()

@app.route('/add_product', methods=['POST'])
def add_student():
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    if request.method == 'POST':
        prod_cat = request.form['prod_cat']
        prod_sub_cat = request.form['prod_sub_cat']
        prod_id = request.form['prod_id']
        cur.execute("INSERT INTO product(product_category, prod_id, product_sub_category) VALUES (%s,%s,%s)", (prod_cat, prod_sub_cat, prod_id))
        conn.commit()
        flash('Product Added successfully')
        return Index()
