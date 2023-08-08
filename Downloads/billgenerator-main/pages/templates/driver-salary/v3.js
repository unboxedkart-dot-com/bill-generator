import React from 'react';
import moment from "moment";
import Image from "next/image";
import STAMP from "../../../assets/Revenue-stamp.jpeg";

function V3({}) {
	const data = {
		driverName: "John Doe",
		employeeName: "John Doe",
		vehicleNumber: "MH 12 AB 1234",
		salary: "10000",
		date: moment().format("DD MMM YYYY"),
		month: "April",
	}
	return (
		<div className={"driver_salary V3"}>
			<p className="text-center text mb-2 text-bolder font-18">Driver Salary Receipt</p>
			<p className="text">This is to certify that I have paid ₹ <span className={"text-bold"}>{data.salary}</span>
				to driver, Mr.<span className="text-bold">{data.driverName}</span> for the month of <span
					className="text-bold">{data.month}</span> (Acknowledged receipt enclosed).
				I also declare that the driver is exclusively utilized for official purpose only.
				Please reimburse the above amount. I further declare that what is stated above is correct and true.</p>
			<p className="text mb-1"><span className={"text-bold"}>Employee Name: </span> {data.employeeName}</p>
			<p className="text mb-1"><span className={"text-bold"}>Date: </span> {data.date}</p>
			<div className="border-bottom mb-2"/>
			<p className="text-center text mb-1 text-bolder font-18">Receipt Acknowledgement</p>
			<p className="text mb-1"><span className={"text-bold"}>Date of Receipt: </span> {data.date}</p>
			<p className="text mb-1"><span className={"text-bold"}>For the Month of: </span> {data.month}</p>
			<p className="text mb-1"><span className={"text-bold"}>Name of Driver: </span> {data.driverName}</p>
			<p className="text mb-1"><span className={"text-bold"}>Vehicle No: </span> {data.vehicleNumber}</p>

			<p className="text mb-2">Received a sum of ₹ <span className="text-bold">{data.salary}</span> only for the <span
				className="text-bold">{data.month}</span> month from Mr / Mrs <span
				className="text-bold">{data.employeeName}</span>.
			</p>
			<p className={"text text-bolder mb-1"}>Revenue Stamp</p>
			<Image src={STAMP} alt="stamp" className={"stamp"}/>
		</div>
	);
}

export default V3;
