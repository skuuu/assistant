# Assistant
Dockerized Flask app with PostgreSQL database and two endpoints for users to query information from Wikipedia files 
  
To start the Flask web app:   
docker compose up  
PostgreSQL database is automatically set up and populated with Wikipedia data.  
  
To run a SQL query:   
navigate to /query to find a form for the SQL query
  
To check the most outdated document for a given category:   
Fill in the category name in the form in /check

To batch append data: 
Fill in the data as a list of tuples in /add_page, /add_category, /add_apgelinks and /add_categorylinks

TODO
- Protect against SQL injections by checking the input strings
- Error handling
- Deploy to Heroku 
- Schedule monthly data ingestion by setting up crontogo 