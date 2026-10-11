def wind_chill(temp, wind_speed, a=13.12, b=0.6215, c=-11.37, d=0.16, e=0.3965):
    """
    Converts temperature and wind speed into wind-chill index.
    Formula: wci = a + b*T + c*W^d + e*T*W^d, where T is temperature and W is wind speed
    Parameters
        temp: temperature in Celsius
        wind_speed: wind speed in km/h
        a: constant with default value
        b: constant with default value
        c: constant with default value
        d: constant with default value
        e: constant with default value
    Example use:
    >>> wind_chill(-20, 30)
    -33
    """
    if (wind_speed < 5):
        r = temp
    else:
        r = round(a + b*temp + c*(wind_speed**d) + e*temp*(wind_speed**d))
    return(r)  # This is a placeholder for your code
