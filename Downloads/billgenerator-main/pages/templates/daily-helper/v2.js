import React from 'react';
import Image from "next/image";
import STAMP from "../../../assets/Revenue-stamp.jpeg";
import moment from "moment";

function V2({}) {
	const data = {
		helperName: "John Doe",
		employeeName: "John Doe",
		vehicleNumber: "MH 12 AB 1234",
		salary: "10000",
		profession: "Helper",
		date: moment().format("DD MMM YYYY"),
		month: "April",
	}
	return (
		<div className={"daily-helper V2"}>
			<p className="text-right text mb-1">Date: 20 Jan 2023</p>
			<p className="text-center text mb-2 text-bolder font-18">Daily Helper Receipt</p>
			<p className="text mb-1"><span className={"text-bold"}>Working As:</span> {data.profession}</p>
			<p className="text mb-1"><span className={"text-bold"}>Salary of the Month:</span> {data.salary}</p>
			<p className="text mb-1"><span className={"text-bold"}>Amount Paid:</span> {data.salary}</p>
			<p className="text mb-1"><span className={"text-bold"}>Date:</span> {data.date}</p>
			<p className="text mb-1">Received From Mr./Ms. <span className="text-bold">{data.employeeName}</span>
				₹<span className="text-bold">{data.salary}</span> to his/her Profession Mr./Ms.
				<span className="text-bold">{data.helperName}</span>towards salary of the month of {data.month}</p>
			<p className="text text-right mb-1"><span className={"text-bold"}>Employee Name:</span> {data.employeeName}</p>

			<p className="text-center text mb-2 text-bolder font-18">Receipt Acknowledgement</p>
			<p className="text mb-1"><span className={"text-bold"}>Salary of the Month::</span> {data.month}</p>
			<p className="text mb-1"><span className={"text-bold"}>Amount Paid:</span> {data.salary}</p>
			<p className="text mb-1"><span className={"text-bold"}>Date:</span> {data.date}</p>
			<p className="text mb-1">Received From Mr./Ms. <span className="text-bold">{data.employeeName}</span>
				₹<span className="text-bold">{data.salary}</span> to his/her Profession Mr./Ms.
				<span className="text-bold">{data.helperName}</span>towards salary of the month of {data.month}</p>
			<p className="text text-right mb-1"><span className={"text-bold"}>Helper Name:</span> {data.helperName}</p>

			<p className={"text mb-1"}>Revenue Stamp</p>
			<Image src={STAMP} alt="stamp" className={"stamp"}/>
		</div>
	);
}

export default V2;
