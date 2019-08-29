import numpy as np
import pandas as pd

import sqlalchemy
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine, func

from flask import Flask, jsonify



#################################################
# Database Setup
#################################################
engine = create_engine("sqlite:///Resources/hawaii.sqlite")

# reflect an existing database into a new model
Base = automap_base()
# reflect the tables
Base.prepare(engine, reflect=True)

# Save references to the tables
Measurement = Base.classes.measurement
Station = Base.classes.station

# Create our session (link) from Python to the DB
session = Session(engine)


#################################################
# Flask Setup
#################################################
app = Flask(__name__)


#################################################
# Flask Routes
#################################################


@app.route("/")
def home():
    """List all available api routes."""
    return (
        f"Available Routes:<br/>"
        f"/api/v1.0/percipition<br/>"
        f"/api/v1.0/stations<br/>"
        f"/api/v1.0/tobs<br/>"
        f"/api/v1.0/<start><br/>"
        f"/api/v1.0/<start>/<end>"
    )

@app.route("/api/v1.0/percipition")
def prcp():
    # Create our session (link) from Python to the DB
    session = Session(engine)

    """Return dates and percipition"""
    # Query measurement
    results = session.query(Measurement.date, Measurement.prcp).all()

    session.close()

    # create dictionary with date as key and prcp as value
    prcp_by_date = {}
    for date, prcp in results:
        prcp_by_date['date'] = date
        prcp_by_date['prcp'] = prcp
    

    return jsonify(prcp_by_date)



@app.route("/api/v1.0/stations")
def stations():
    # Create our session (link) from Python to the DB
    session = Session(engine)

    """Return dates and percipition"""
    # Query measurement
    results = session.query(Station.name).all()

    session.close()
    
    # Convert list of tuples into normal list
    all_names = list(np.ravel(results))

    return jsonify(all_names)






if __name__ == '__main__':
    app.run(debug=True)




















