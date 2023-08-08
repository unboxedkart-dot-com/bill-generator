import React from 'react';
import moment from "moment/moment";
import Image from "next/image";
import SIDE_BANK_LOGO from "../../../assets/side-logo-fuel-hdfc.png";
import INDIAN_OIL_LOGO from "../../../assets/indian-oil-logo.png";

function V2({}) {
	const data = {
		stationName: "Indian Oil",
		stationAddress: "20, Sarjapur Main Rd, near Wipro Office, Carmelaram, Doddakannelli, Bengaluru, Karnataka 560035",
		GSTNumber: "M43010GH195260",
		receiptNumber: "123456789",
		productName: "Petrol",
		productPrice: 100,
		amountPaid: 2222,
		vehicleNumber: "KA 01 AB 1234",
		customerName: "John Doe",
		date: moment().format("DD MMM YYYY"),
		time: moment().format("hh:mm A"),
		modeOfPayment: "Cash",
	}
	return (
		<div className={"fuel V2"}>
			<Image className={"side-image top"} src={SIDE_BANK_LOGO} alt="side-logo-fuel-hdfc"/>
			<Image className={"side-image bottom"} src={SIDE_BANK_LOGO} alt="side-logo-fuel-hdfc"/>

			<div className="logo-container">
				<Image className={"logo"} src={INDIAN_OIL_LOGO} alt="indian-oil-logo"/>
			</div>
			<p className="center text mb-1">WELCOME!!</p>
			<p className="center text mb-1">{data.stationName} {data.stationAddress}</p>
			<div className="container">
				<p className="text">Tel. No.: 2727850</p>
				<p className="text">Receipt No.: {data.receiptNumber}</p>
				<p className="text">FCC ID: 00000008067</p>
				<p className="text">FIP No.: 91</p>
				<p className="text mb-2">Nozzle No.: 06</p>

				<p className="text">PRODUCT: {data.productName}</p>
				<p className="text">RATE/LTR: ₹ {data.productPrice}</p>
				<p className="text">AMOUNT: ₹ {data.amountPaid}</p>
				<p className="text mb-2">VOLUME(LTR.): {(data.amountPaid / data.productPrice).toFixed(2)} lt</p>

				<p className="text">VEH TYPE: {data.productName}</p>
				<p className="text">VEH NO: {data.vehicleNumber}</p>
				<p className="text mb-2">CUSTOMER NAME: {data.customerName}</p>

				<div className="row mb-2">
					<div className="col">
						<p className="text">Date: {data.date}</p>
					</div>
					<div className="col">
						<p className="text">Time: {data.time}</p>
					</div>
				</div>

				<p className="text">MODE: {data.modeOfPayment}</p>
				<p className="text">GST No: {data.GSTNumber}</p>
				<p className="text">LST No.: </p>
				<p className="text">VAT No.: </p>
				<p className="text mb-3">ATTENDANT ID: Not Available</p>

				<p className="text mb-2">SAVE FUEL YAANI SAVE MONEY !! THANKS FOR FUELLING WITH US. YOU CAN NOW CALL US ON 1800
					226344 (TOLL-FREE) FOR QUERIES/COMPLAINTS.</p>
			</div>
		</div>
	);
}

export default V2;
