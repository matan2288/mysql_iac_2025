const fs = require("fs");
const mysql = require("mysql2");
const csv = require("csv-parser");

const connection = mysql.createConnection({
	host: "localhost",
	user: "root",
	password: "", // אם יש סיסמה שים אותה כאן
	database: "sneakers",
});

connection.connect();

fs.createReadStream("../Databases/sneakers_streetwear_sales_data.csv")
	.pipe(csv())
	.on("data", (row) => {
		const sql = `
      INSERT INTO sneakers_table 
      (Date, ProductName, ProductType, Brand, Gender, Category, Country, Quantity, UnitPrice, Amount, PaymentMode)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`;

		const values = [
			row["Date"],
			row["Product Name"], // נשאר כמו בקובץ
			row["Product Type"],
			row["Brand"],
			row["Gender"],
			row["Category"],
			row["Country"],
			parseInt(row["Quantity"]),
			parseFloat(row["Unit Price ($)"]),
			parseFloat(row["Amount ($)"]),
			row["Payment Mode"],
		];

		connection.query(sql, values, (err) => {
			if (err) console.error(err);
		});
	})
	.on("end", () => {
		console.log("✅ CSV data successfully inserted!");
		connection.end();
	});
