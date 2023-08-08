import React from 'react';
import Image from "next/image";
import INDIAN_OIL_LOGO from "../../../assets/indian-oil-color-logo.png";
import moment from "moment";

function V3({}) {
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
		density: 0.75,
		nozzleNumber: 6,
	}
	return (
		<div className={"fuel V3"}>
			<Image className={"logo"} src={INDIAN_OIL_LOGO} alt="indian-oil-logo"/>
			<p className="text text-center">{data.stationName}</p>
			<p className="text text-center">{data.stationAddress}</p>
			<p className="text text-center mb-2">ORIGINAL</p>
			<div className="row mb-1">
				<div className="col">
					<p className="text text-left">{data.date}</p>
				</div>
				<div className="col">
					<p className="text text-right"> {data.time}</p>
				</div>
			</div>
			<div className="row">
				<div className="col">
					<p className="text text-left">GST No:</p>
				</div>
				<div className="col">
					<p className="text text-right"> {data.GSTNumber}</p>
				</div>
			</div>
			<div className="row">
				<div className="col">
					<p className="text text-left">INVOICE NO:</p>
				</div>
				<div className="col">
					<p className="text text-right"> {data.receiptNumber}</p>
				</div>
			</div>
			<div className="row">
				<div className="col">
					<p className="text text-left">VEHICLE NO:</p>
				</div>
				<div className="col">
					<p className="text text-right"> {data.vehicleNumber}</p>
				</div>
			</div>
			<div className="row">
				<div className="col">
					<p className="text text-left">NOZZLE NO:</p>
				</div>
				<div className="col">
					<p className="text text-right"> {data.nozzleNumber}</p>
				</div>
			</div>
			<div className="row">
				<div className="col">
					<p className="text text-left">PRODUCT:</p>
				</div>
				<div className="col">
					<p className="text text-right"> {data.productName}</p>
				</div>
			</div>
			<div className="row">
				<div className="col">
					<p className="text text-left">DENSITY:</p>
				</div>
				<div className="col">
					<p className="text text-right"> {data.density} Kg/m3</p>
				</div>
			</div>
			<div className="row">
				<div className="col">
					<p className="text text-left">RATE:</p>
				</div>
				<div className="col">
					<p className="text text-right"> {data.productPrice} INR/Ltr</p>
				</div>
			</div>
			<div className="row">
				<div className="col">
					<p className="text text-left">VOLUME:</p>
				</div>
				<div className="col">
					<p className="text text-right"> {(data.amountPaid / data.productPrice).toFixed(2)} Ltr</p>
				</div>
			</div>
			<div className="row mb-3">
				<div className="col">
					<p className="text text-left">AMOUNT:</p>
				</div>
				<div className="col">
					<p className="text text-right"> {data.amountPaid} INR</p>
				</div>
			</div>
			<p className="text text-center">Thanks you Visit Again</p>
		</div>
	);
}

export default V3;
