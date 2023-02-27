from flask import Flask, request, jsonify, render_template
from flask_sqlalchemy import SQLAlchemy
import os
import pandas as pd

app = Flask(__name__)

if __name__ == '__main__':
    app.run(debug=True)

app.config['SQLALCHEMY_DATABASE_URI'] = os.environ.get('DATABASE_URL')
db = SQLAlchemy(app)


class Page(db.Model):
  page_id = db.Column(db.Integer, primary_key=True)
  page_title = db.Column(db.String(), unique=True, nullable=False)

  def __init__(self, page_title):
    self.page_title = page_title

@app.route('/pages/<id>', methods=['GET'])
def get_item(id):
  item = Page.query.get(id)
  del item.__dict__['_sa_instance_state']
  return jsonify(item.__dict__)

@app.route('/query')
def render_query():
    return render_template('form-query.html')

@app.route('/check')
def render_check():
    return render_template('form-check.html')

@app.route('/add_page')
def render_add_page():
    return render_template('form-add.html')

@app.route('/add_category')
def render_add_category():
    return render_template('form-add.html')

@app.route('/add_categorylinks')
def render_add_categorylinks():
    return render_template('form-add.html')

@app.route('/add_pagelinks')
def render_add_pagelinks():
    return render_template('form-add.html')

@app.route('/query', methods=['POST'])
def form_query():
    sql = request.form['query']
    temp = db.engine.execute(sql).fetchall()
    result = [{k: item[k] for k in item.keys()} for item in temp]
    return jsonify(result)

@app.route('/check', methods=['POST'])
def form_check():
  category = str(request.form['check'])
  print(category)

  #query to fetch the most outdated pages for the user-defined category
  sql = f"""
  WITH outdated_pages as (
  SELECT DISTINCT
    pl.pl_from as source_page_id, 
    pg.page_title as source_page_title, 
    pl.pl_title as ref_page_title, 
    to_timestamp(pg.page_touched, 'YYYYMMDDHH24MISS') as source_page_updated, 
    to_timestamp(ref_pg.page_touched, 'YYYYMMDDHH24MISS') as ref_page_updated
  FROM 
    pagelinks as pl 
  LEFT JOIN
    page as pg 
    on pl.pl_from = pg.page_id 
  LEFT JOIN 
    page as ref_pg 
    on pl.pl_title = ref_pg.page_title 
  LEFT JOIN
    categorylinks as catlinks 
    on pl.pl_from = catlinks.cl_from 
  WHERE 
    catlinks.cl_to = '{category}'
    and pg.page_touched <= ref_pg.page_touched
  )
  SELECT
    source_page_id, 
    source_page_title
  FROM  
    outdated_pages
  group by 
    1,2
  ORDER BY
    max(ref_page_updated - source_page_updated) DESC
  LIMIT 1
  """
  temp = db.engine.execute(sql).fetchall()
  result = [{k: item[k] for k in item.keys()} for item in temp]
  if len(result) == 0: 
    return 'No results' 
  else:
    return jsonify(result)

@app.route('/add_category', methods=['POST'])
def form_add_category():
  data = request.form['data'] #input as a list ot tuples
  df = pd.DataFrame(eval(data), columns=['cat_id', 'cat_title', 'cat_pages', 'cat_subcats', 'cat_files'])
  df  = df.set_index('cat_id')
  df.to_sql('category', db.engine, if_exists='append')
  return 'Success'

@app.route('/add_page', methods=['POST'])
def form_add_page():
  data = request.form['data']
  df = pd.DataFrame(eval(data), columns=['page_id', 'page_namespace', 'page_title', 'page_is_redirect', 'page_is_new', 'page_random', 'page_touched', 'page_links_updated', 'page_latest','page_len', 'page_content_model', 'page_lang'])
  df  = df.set_index('page_id')
  df.to_sql('page', db.engine, if_exists='append')
  return 'Success'
 
@app.route('/add_pagelinks', methods=['POST'])
def form_add_pagelinks():
  data = request.form['data']
  df = pd.DataFrame(eval(data), columns=['pl_from', 'pl_namespace', 'pl_title', 'pl_from_namespace']) 
  df  = df.set_index(['pl_from, pl_namespace, pl_title']) 
  df.to_sql('pagelinks', db.engine, if_exists='append')
  return 'Success'

@app.route('/add_categorylinks', methods=['POST'])
def form_add_categorylinks():
  data = request.form['data']
  df = pd.DataFrame(eval(data), columns=['cl_from', 'cl_to', 'page_title', 'cl_sortkey', 'cl_timestamp', 'cl_sortkey_prefix', 'cl_collation', 'cl_type'])
  df  = df.set_index(['cl_from, cl_to'])
  df.to_sql('categorylinks', db.engine, if_exists='append')
  return 'Success'
