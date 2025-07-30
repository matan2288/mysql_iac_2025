const fs = require('fs');
const mysql = require('mysql2');

const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  database: 'sneakers',
  password: '',
  localInfile: true,
  streamFactory: () => fs.createReadStream('/path/to/file.csv'),
});

connection.query(`
  LOAD DATA LOCAL INFILE '/path/to/file.csv'
  INTO TABLE sneakers_table
  FIELDS TERMINATED BY ','
  ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 ROWS;
`, (err, results) => {
  if (err) throw err;
  console.log('Imported!');
});