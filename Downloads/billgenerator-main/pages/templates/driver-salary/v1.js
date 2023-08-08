import React from 'react';
import STAMP from '../../../assets/Revenue-stamp.jpeg';
import Image from "next/image";
import moment from "moment";

function V1({}) {
	const data = {
		driverName: "John Doe",
		employeeName: "John Doe",
		vehicleNumber: "MH 12 AB 1234",
		salary: "10000",
		date: moment().format("DD MMM YYYY"),
		month: "April",
	}
	return (
		<div className={"driver_salary V1"}>
			<p className="text-right text mb-1">Date: 20 Jan 2023</p>
			<p className="text-center text mb-1 text-bolder font-18">Driver Salary Receipt</p>

			<p className={"text mb-2"}>This is to certify that Mr./Ms. <span
				className={"text-bold"}>{data.employeeName}</span> have paid
				₹ <span className="text-bold">{data.salary}</span> to driver Mr/Ms{" "}
				<span className="text-bold">{data.driverName}</span> towards salary of the month of{" "}
				<span className="text-bold">{data.month}</span>
				(Acknowledged receipt enclosed). I also declare that the driver is exclusively utilized for official purpose
				only.</p>

			<p className="text mb-2">Please reimburse the above amount. I further declare that what is stated above is correct
				and true.</p>
			<p className="text mb-1"><span className={"text-bold"}>Vehicle Number:</span> {data.vehicleNumber}</p>
			<p className="text text-right mb-1"><span className={"text-bold"}>Date:</span> {data.date}</p>
			<p className="text mb-1"><span className={"text-bold"}>Driver Name:</span> {data.driverName}</p>
			<p className="text text-right mb-1"><span className={"text-bold"}>Employee Name:</span> {data.employeeName}</p>
			<p className={"text mb-1"}>Revenue Stamp</p>
			<Image src={STAMP} alt="stamp" className={"stamp"}/>
		</div>
	);
}

export default V1;
