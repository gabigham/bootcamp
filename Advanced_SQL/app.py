
#################################################
# Written by George Bigham for UCDavis bootcamp
#################################################



import numpy as np
import pandas as pd

import sqlalchemy
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine, func

from flask import Flask, jsonify

import datetime as dt
from datetime import timedelta
from datetime import datetime

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
    results = session.query(Measurement.date, func.sum(Measurement.prcp)).\
              group_by(Measurement.date).all()

    session.close()

    return jsonify(results)



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



@app.route("/api/v1.0/tobs")
def tobs():
    # Create our session (link) from Python to the DB
    session = Session(engine)

    """Return tobs from last year of data"""
    # Query last date
    last_date = session.query(Measurement.date).order_by(Measurement.date.desc()).first()
    datetime_object = datetime.strptime(last_date[0], '%Y-%m-%d').date()
    year_ago = datetime_object - timedelta(days=365)

    sel = [Measurement.station, 
        Measurement.date, 
        Measurement.tobs]

    results = session.query(*sel).filter(Measurement.date>=year_ago)

    session.close()

    all_tobs = []
    for station, date, tobs in results:
        tobs_dict = {}
        tobs_dict["station"] = station
        tobs_dict["date"] = date
        tobs_dict["tobs"] = tobs
        all_tobs.append(tobs_dict)

    return jsonify(all_tobs)



@app.route("/api/v1.0/<start>")
def start(start):
    # Create our session (link) from Python to the DB
    session = Session(engine)

    """Return min, avg, and max of temp from start date"""
    sel = [func.min(Measurement.tobs),
           func.avg(Measurement.tobs),
           func.max(Measurement.tobs)]

    results = session.query(*sel).filter(Measurement.date>=start)

    session.close()

    all_stats = []
    stats_dict = {}
    stats_dict["min"] = results[0][0]
    stats_dict["avg"] = results[0][1]
    stats_dict["max"] = results[0][2]
    all_stats.append(stats_dict)

    return jsonify(all_stats)



@app.route("/api/v1.0/<start>/<end>")
def start_end(start, end):    # Create our session (link) from Python to the DB
    session = Session(engine)

    """Return min, avg, and max of temp from start date"""
    sel = [func.min(Measurement.tobs),
           func.avg(Measurement.tobs),
           func.max(Measurement.tobs)]

    results = session.query(*sel).filter(Measurement.date>=start).\
                filter(Measurement.date<=end).all()

    session.close()
    
    all_stats = []   
    stats_dict = {}
    stats_dict["min"] = results[0][0]
    stats_dict["avg"] = results[0][1]
    stats_dict["max"] = results[0][2]
    all_stats.append(stats_dict)


    return jsonify(all_stats)
    


#################################################
# Run Flask 
#################################################

if __name__ == '__main__':
    app.run(debug=True)




















