import React from 'react';
import moment from "moment/moment";
import Image from "next/image";
import STAMP from "../../../assets/Revenue-stamp.jpeg";

function V3({}) {
	const data = {
		helperName: "John Doe",
		employeeName: "John Doe",
		salary: "10000",
		profession: "Helper",
		date: moment().format("DD MMM YYYY"),
		month: "April",
	}
	return (
		<div className={"daily-helper V3"}>
			<p className="text-center text mb-2 text-bolder font-18">Daily Helper Receipt</p>
			<p className="text mb-2">This is to certify that I have paid ₹ <span className="text-bold">{data.salary}</span> to
				his/her Helper Mr/Ms <span className="text-bold">{data.helperName}</span> who is Working
				as {data.profession}. As Helper Name got salary of the month of
				<span className="text-bold">{data.month}</span> (Acknowledged receipt enclosed). I also
				declare that the Mr/Ms {data.helperName} is exclusively utilized for official purpose only.
				Please reimburse the above amount. I further declare that what is stated above is correct and true.</p>
			<p className="text mb-1"><span className={"text-bold"}>Employee Name: </span> {data.employeeName}</p>
			<p className="text mb-1"><span className={"text-bold"}>Date: </span> {data.date}</p>
			<div className="border-bottom mb-2"/>
			<p className="text-center text mb-1 text-bolder font-18">Receipt Acknowledgement</p>
			<p className="text mb-1"><span className={"text-bold"}>Date of Receipt: </span> {data.date}</p>
			<p className="text mb-1"><span className={"text-bold"}>For the Month of: </span> {data.month}</p>
			<p className="text mb-1"><span className={"text-bold"}>Name of Helper: </span> {data.helperName}</p>
			<p className="text mb-1"><span className={"text-bold"}>Working As: </span> {data.profession}</p>

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
