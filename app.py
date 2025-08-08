# app.py
# This is the main application file for the Car Rental website.
# All configurations are included in this single file.

from flask import Flask, render_template, request, redirect, url_for, session, flash
from flask_mysqldb import MySQL
from werkzeug.security import generate_password_hash, check_password_hash
from datetime import datetime

# Initialize the Flask app
app = Flask(__name__)

# --- ALL CONFIGURATIONS ARE HERE ---
# --- Database Configuration ---
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = '01988087533' # Make sure this password is correct
app.config['MYSQL_DB'] = 'carrentaldb'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'

# --- Secret Key Configuration ---
app.config['SECRET_KEY'] = 'a_very_long_and_random_secret_key_12345'

# Initialize MySQL
mysql = MySQL(app)

# --- Main Routes ---
@app.route('/')
def index():
    return render_template('index.html')

# --- Customer Flow ---
@app.route('/customer/login', methods=['GET', 'POST'])
def customer_login():
    if request.method == 'POST':
        identifier = request.form['identifier']
        password = request.form['password']
        cursor = mysql.connection.cursor()
        cursor.execute("SELECT * FROM CUSTOMERS WHERE EMAIL = %s OR PHONE = %s", (identifier, identifier))
        customer = cursor.fetchone()
        cursor.close()
        if customer and check_password_hash(customer['PASSWORD_HASH'], password):
            session['customer_id'] = customer['CUSTOMER_ID']
            session['customer_name'] = customer['CUSTOMERNAME']
            flash('Login successful!', 'success')
            return redirect(url_for('customer_dashboard'))
        else:
            flash('Invalid credentials. Please try again.', 'danger')
    return render_template('customer_login.html')

@app.route('/customer/signup', methods=['GET', 'POST'])
def customer_signup():
    if request.method == 'POST':
        name = request.form['name']
        email = request.form['email']
        phone = request.form['phone']
        license_no = request.form['license']
        national_id = request.form['national_id']
        password = request.form['password']
        password_hash = generate_password_hash(password)
        try:
            cursor = mysql.connection.cursor()
            cursor.execute(
                "INSERT INTO CUSTOMERS (CUSTOMERNAME, EMAIL, PHONE, DRIVER_LICENSE, NATIONAL_ID, PASSWORD_HASH) VALUES (%s, %s, %s, %s, %s, %s)",
                (name, email, phone, license_no, national_id, password_hash)
            )
            mysql.connection.commit()
            cursor.close()
            flash('Account created successfully! Please log in.', 'success')
            return redirect(url_for('customer_login'))
        except Exception as e:
            flash(f'An error occurred: {e}', 'danger')
            return redirect(url_for('customer_signup'))
    return render_template('customer_signup.html')

@app.route('/customer/logout')
def customer_logout():
    session.pop('customer_id', None)
    session.pop('customer_name', None)
    flash('You have been logged out.', 'info')
    return redirect(url_for('index'))

@app.route('/customer/dashboard')
def customer_dashboard():
    if 'customer_id' not in session:
        return redirect(url_for('customer_login'))
    return render_template('customer_dashboard.html')

@app.route('/customer/orders')
def order_details():
    if 'customer_id' not in session:
        return redirect(url_for('customer_login'))
    customer_id = session['customer_id']
    cursor = mysql.connection.cursor()
    query = """
        SELECT b.BOOKING_ID, b.STARTDATE, b.ENDDATE, b.TOTALAMOUNT, v.BRAND, v.MODEL
        FROM BOOKINGS b JOIN VEHICLES v ON b.VEHICLES_ID = v.VEHICLES_ID
        WHERE b.CUSTOMER_ID = %s AND b.ENDDATE >= CURDATE() ORDER BY b.STARTDATE ASC
    """
    cursor.execute(query, [customer_id])
    orders = cursor.fetchall()
    cursor.close()
    return render_template('order_details.html', orders=orders)

@app.route('/customer/previous_orders')
def previous_orders():
    if 'customer_id' not in session:
        return redirect(url_for('customer_login'))
    customer_id = session['customer_id']
    cursor = mysql.connection.cursor()
    query = """
        SELECT b.BOOKING_ID, b.STARTDATE, b.ENDDATE, b.TOTALAMOUNT, v.BRAND, v.MODEL
        FROM BOOKINGS b JOIN VEHICLES v ON b.VEHICLES_ID = v.VEHICLES_ID
        WHERE b.CUSTOMER_ID = %s AND b.ENDDATE < CURDATE() ORDER BY b.STARTDATE DESC
    """
    cursor.execute(query, [customer_id])
    orders = cursor.fetchall()
    cursor.close()
    return render_template('previous_orders.html', orders=orders)

# --- Employee Flow ---
@app.route('/employee/login', methods=['GET', 'POST'])
def employee_login():
    if request.method == 'POST':
        identifier = request.form['identifier']
        password = request.form['password']
        cursor = mysql.connection.cursor()
        cursor.execute("SELECT * FROM EMPLOYEES WHERE EMAIL = %s OR PHONE = %s", (identifier, identifier))
        employee = cursor.fetchone()
        cursor.close()
        if employee and check_password_hash(employee['PASSWORD_HASH'], password):
            session['employee_id'] = employee['EMPLOYEE_ID']
            session['employee_name'] = employee['EMPLOYEE_NAME']
            flash('Login successful!', 'success')
            return redirect(url_for('employee_dashboard'))
        else:
            flash('Invalid credentials. Please try again.', 'danger')
    return render_template('employee_login.html')

@app.route('/employee/signup', methods=['GET', 'POST'])
def employee_signup():
    if request.method == 'POST':
        name = request.form['name']
        email = request.form['email']
        phone = request.form['phone']
        hire_date = request.form['hire_date']
        password = request.form['password']
        password_hash = generate_password_hash(password)
        try:
            cursor = mysql.connection.cursor()
            cursor.execute(
                "INSERT INTO EMPLOYEES (EMPLOYEE_NAME, EMAIL, PHONE, HIREDATE, PASSWORD_HASH) VALUES (%s, %s, %s, %s, %s)",
                (name, email, phone, hire_date, password_hash)
            )
            mysql.connection.commit()
            cursor.close()
            flash('Employee account created successfully! Please log in.', 'success')
            return redirect(url_for('employee_login'))
        except Exception as e:
            flash(f'An error occurred: {e}', 'danger')
            return redirect(url_for('employee_signup'))
    return render_template('employee_signup.html')

@app.route('/employee/logout')
def employee_logout():
    session.pop('employee_id', None)
    session.pop('employee_name', None)
    flash('You have been logged out.', 'info')
    return redirect(url_for('index'))

@app.route('/employee/dashboard')
def employee_dashboard():
    if 'employee_id' not in session:
        return redirect(url_for('employee_login'))
    return render_template('employee_dashboard.html')

# --- Vehicle Search & Details ---
@app.route('/search')
def search_vehicles():
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM VEHICLES")
    vehicles = cursor.fetchall()
    cursor.close()
    return render_template('search_vehicles.html', vehicles=vehicles)

@app.route('/vehicle/<int:vehicle_id>')
def vehicle_details(vehicle_id):
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM VEHICLES WHERE VEHICLES_ID = %s", [vehicle_id])
    vehicle = cursor.fetchone()
    cursor.close()
    if vehicle:
        return render_template('vehicle_details.html', vehicle=vehicle)
    return "Vehicle not found", 404

@app.route('/book/<int:vehicle_id>', methods=['POST'])
def book_vehicle(vehicle_id):
    if 'customer_id' not in session:
        flash('You must be logged in to book a vehicle.', 'warning')
        return redirect(url_for('customer_login'))
    customer_id = session['customer_id']
    start_date = request.form['start_date']
    end_date = request.form['end_date']
    try:
        cursor = mysql.connection.cursor()
        cursor.execute("SELECT RENTPERDAY FROM VEHICLES WHERE VEHICLES_ID = %s", [vehicle_id])
        rent_per_day = cursor.fetchone()['RENTPERDAY']
        days = (datetime.strptime(end_date, '%Y-%m-%d') - datetime.strptime(start_date, '%Y-%m-%d')).days
        if days < 1:
            flash('End date must be after the start date.', 'danger')
            return redirect(url_for('vehicle_details', vehicle_id=vehicle_id))
        total_amount = rent_per_day * days
        cursor.execute(
            "INSERT INTO BOOKINGS (CUSTOMER_ID, VEHICLES_ID, BOOKINGDATE, STARTDATE, ENDDATE, TOTALAMOUNT) VALUES (%s, %s, CURDATE(), %s, %s, %s)",
            (customer_id, vehicle_id, start_date, end_date, total_amount)
        )
        mysql.connection.commit()
        cursor.close()
        flash('Vehicle booked successfully!', 'success')
        return redirect(url_for('customer_dashboard'))
    except Exception as e:
        flash(f'Booking failed: {e}', 'danger')
        return redirect(url_for('vehicle_details', vehicle_id=vehicle_id))

# --- Employee Management CRUD Routes ---
@app.route('/employee/bookings')
def manage_bookings():
    if 'employee_id' not in session:
        return redirect(url_for('employee_login'))
    cursor = mysql.connection.cursor()
    query = """
        SELECT b.BOOKING_ID, b.STARTDATE, b.ENDDATE, b.TOTALAMOUNT, c.CUSTOMERNAME, v.MODEL, v.BRAND
        FROM BOOKINGS b JOIN CUSTOMERS c ON b.CUSTOMER_ID = c.CUSTOMER_ID
        JOIN VEHICLES v ON b.VEHICLES_ID = v.VEHICLES_ID ORDER BY b.STARTDATE DESC
    """
    cursor.execute(query)
    bookings = cursor.fetchall()
    cursor.close()
    return render_template('manage_bookings.html', bookings=bookings)

@app.route('/employee/bookings/add', methods=['GET', 'POST'])
def add_booking():
    if 'employee_id' not in session:
        return redirect(url_for('employee_login'))
    if request.method == 'POST':
        customer_id = request.form['customer_id']
        vehicle_id = request.form['vehicle_id']
        start_date = request.form['start_date']
        end_date = request.form['end_date']
        try:
            cursor = mysql.connection.cursor()
            cursor.execute("SELECT RENTPERDAY FROM VEHICLES WHERE VEHICLES_ID = %s", [vehicle_id])
            rent_per_day = cursor.fetchone()['RENTPERDAY']
            days = (datetime.strptime(end_date, '%Y-%m-%d') - datetime.strptime(start_date, '%Y-%m-%d')).days
            if days < 1:
                flash('End date must be after start date.', 'danger')
                return redirect(url_for('add_booking'))
            total_amount = rent_per_day * days
            cursor.execute(
                "INSERT INTO BOOKINGS (CUSTOMER_ID, VEHICLES_ID, BOOKINGDATE, STARTDATE, ENDDATE, TOTALAMOUNT) VALUES (%s, %s, CURDATE(), %s, %s, %s)",
                (customer_id, vehicle_id, start_date, end_date, total_amount)
            )
            mysql.connection.commit()
            cursor.close()
            flash('New booking added successfully!', 'success')
            return redirect(url_for('manage_bookings'))
        except Exception as e:
            flash(f'Error adding booking: {e}', 'danger')
            return redirect(url_for('add_booking'))
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT CUSTOMER_ID, CUSTOMERNAME FROM CUSTOMERS")
    customers = cursor.fetchall()
    cursor.execute("SELECT VEHICLES_ID, BRAND, MODEL FROM VEHICLES")
    vehicles = cursor.fetchall()
    cursor.close()
    return render_template('add_booking.html', customers=customers, vehicles=vehicles)

@app.route('/employee/payments')
def manage_payments():
    if 'employee_id' not in session:
        return redirect(url_for('employee_login'))
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM PAYMENTS ORDER BY PAYMENTDATE DESC")
    payments = cursor.fetchall()
    cursor.close()
    return render_template('manage_payments.html', payments=payments)

@app.route('/employee/vehicles')
def manage_vehicles():
    if 'employee_id' not in session:
        return redirect(url_for('employee_login'))
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM VEHICLES ORDER BY BRAND, MODEL")
    vehicles = cursor.fetchall()
    cursor.close()
    return render_template('manage_vehicles.html', vehicles=vehicles)

@app.route('/employee/maintenance')
def manage_maintenance():
    if 'employee_id' not in session:
        return redirect(url_for('employee_login'))
    cursor = mysql.connection.cursor()
    query = """
        SELECT m.MAINTAINTANCE_ID, m.VEHICLES_ID, m.MAINTAINTANCEDATE, m.COST, v.BRAND, v.MODEL
        FROM VEHICLESMAINTAINTANCE m JOIN VEHICLES v ON m.VEHICLES_ID = v.VEHICLES_ID
        ORDER BY m.MAINTAINTANCEDATE DESC
    """
    cursor.execute(query)
    maintenance_records = cursor.fetchall()
    cursor.close()
    return render_template('manage_maintenance.html', maintenance_records=maintenance_records)

@app.route('/employee/availability')
def manage_availability():
    if 'employee_id' not in session:
        return redirect(url_for('employee_login'))
    cursor = mysql.connection.cursor()
    query = """
        SELECT a.AVAILABILITY_ID, a.VEHICLES_ID, a.AVAILABLE_FROM, a.AVAILABLE_TO, a.STATUS, v.BRAND, v.MODEL
        FROM VEHICLES_AVAILABILITY a JOIN VEHICLES v ON a.VEHICLES_ID = v.VEHICLES_ID
        ORDER BY a.VEHICLES_ID, a.AVAILABLE_FROM
    """
    cursor.execute(query)
    availability_records = cursor.fetchall()
    cursor.close()
    return render_template('manage_availability.html', availability_records=availability_records)

@app.route('/employee/branches')
def manage_branches():
    if 'employee_id' not in session:
        return redirect(url_for('employee_login'))
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM BRANCHES ORDER BY BRACHNAME")
    branches = cursor.fetchall()
    cursor.close()
    return render_template('manage_branches.html', branches=branches)

@app.route('/employee/inventory')
def manage_inventory():
    if 'employee_id' not in session:
        return redirect(url_for('employee_login'))
    cursor = mysql.connection.cursor()
    query = """
        SELECT i.INVENTORY_ID, i.QUANTITY, v.BRAND, v.MODEL, b.BRACHNAME
        FROM VEHICLESINVENTORY i JOIN VEHICLES v ON i.VEHICLES_ID = v.VEHICLES_ID
        JOIN BRANCHES b ON i.BRANCH_ID = b.BRANCH_ID
        ORDER BY b.BRACHNAME, v.BRAND, v.MODEL
    """
    cursor.execute(query)
    inventory_records = cursor.fetchall()
    cursor.close()
    return render_template('manage_inventory.html', inventory_records=inventory_records)

@app.route('/employee/feedbacks')
def manage_feedbacks():
    if 'employee_id' not in session:
        return redirect(url_for('employee_login'))
    cursor = mysql.connection.cursor()
    query = """
        SELECT f.FEEDBACK_ID, f.RATING, f.COMMENTS, f.FEEDBACKDATE, c.CUSTOMERNAME
        FROM FEEDBACKS f JOIN CUSTOMERS c ON f.CUSTOMER_ID = c.CUSTOMER_ID
        ORDER BY f.FEEDBACKDATE DESC
    """
    cursor.execute(query)
    feedback_records = cursor.fetchall()
    cursor.close()
    return render_template('manage_feedbacks.html', feedback_records=feedback_records)

# Run the application
if __name__ == '__main__':
    app.run(debug=True)
