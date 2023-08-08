import React from 'react';
import moment from "moment/moment";
import Image from "next/image";
import STAMP from "../../../assets/Revenue-stamp.jpeg";

function V1({}) {
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
		<div className={"daily-helper V1"}>
			<p className="text-right text mb-1">Date: {data.date}</p>
			<p className="text-center text mb-1 text-bolder font-18">Daily Helper Receipt</p>

			<p className={"text mb-2"}>
				This is to certify that Mr./Ms. <span className="text-bold">{data.employeeName}</span> have paid ₹ <span
				className="text-bold">{data.salary}</span> to his/her Helper Mr/Ms <span
				className="text-bold">{data.helperName}</span> who is
				Working as Profession. As Helper Name got salary of the month of <span
				className="text-bold">{data.month}</span> (Acknowledged receipt enclosed). I
				also declare that the Mr/Ms <span className="text-bold">{data.helperName}</span>
				is exclusively utilized for official purpose only.
			</p>

			<p className="text mb-2">Please reimburse the above amount. I further declare that what is stated above is correct
				and true.</p>
			<p className="text  mb-1"><span className={"text-bold"}>Date:</span> {data.date}</p>
			<p className="text mb-1"><span className={"text-bold"}>Helper Name:</span> {data.helperName}</p>

			<p className="text text-right mb-1"><span className={"text-bold"}>Employee Name:</span> {data.employeeName}</p>
			<p className={"text mb-1"}>Revenue Stamp</p>
			<Image src={STAMP} alt="stamp" className={"stamp"}/>
		</div>
	);
}

export default V1;
