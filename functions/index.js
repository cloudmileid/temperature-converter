const functions = require('@google-cloud/functions-framework');

functions.http('convertTemp', (req, res) => {
 var dirn = req.query.convert;
 var ctemp = (req.query.temp - 32) * 5/9;
 var target_unit = 'Celsius';

 if (req.query.temp === undefined) {
    res.status(400);
    res.send('Temperature value not supplied in request.');
 }
 if (dirn === undefined)
   dirn = process.env.TEMP_CONVERT_TO;
 if (dirn === 'ctof') {
   ctemp = (req.query.temp * 9/5) + 32;
   target_unit = 'Fahrenheit';
 }

 res.send(`Temperature in ${target_unit} is: ${ctemp.toFixed(2)}.`);
});
