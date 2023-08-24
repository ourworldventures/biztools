module main

import os
import freeflowuniverse.crystallib.bizmodel
import freeflowuniverse.crystallib.spreadsheet
import cli { Command, Flag }

fn run_planner(cmd Command) ! {

	source:=cmd.args[0]

	dest := cmd.flags.get_string('dest') or {""}

	mut m := bizmodel.new(path: source)!
	println('')
	println(m.sheet.wiki(includefilter: ['funding'], name: 'FUNDING')!)
	println(m.sheet.wiki(includefilter: ['rev'], name: 'revenue')!)
	println(m.sheet.wiki(includefilter: ['revtotal'], name: 'revenue total')!)
	println(m.sheet.wiki(includefilter: ['revtotal2'], title_disable: true)!)
	println(m.sheet.wiki(includefilter: ['cogs'], name: 'cogs')!)
	println(m.sheet.wiki(includefilter: ['margin'], name: 'margin')!)
	println(m.sheet.wiki(includefilter: ['hrnr'], name: 'HR Teams')!)
	println(m.sheet.wiki(includefilter: ['hrcost'], name: 'HR Cost')!)
	println(m.sheet.wiki(includefilter: ['ocost'], name: 'COSTS')!)
	println(m.sheet.wiki(includefilter: ['pl'], name: 'P&L Overview')!)

	m.sheet.group2row(
		name: 'company_result'
		include: ['pl']
		tags: 'result'
		descr: 'Net Company Result.'
	)!

	println(m.sheet.wiki(includefilter: ['result'], name: 'Net Company Result.',period_months:3)!)

	mut company_result:=m.sheet.row_get("company_result")!	
	mut cashflow:=company_result.recurring(
		name: 'Cashflow'
		tags: 'cashflow'
		descr: 'Cashflow of company.'	
	)!

	// println(cashflow)

	println(m.sheet.wiki(includefilter: ['cashflow'], name: 'cashflow_aggregated',period_months:3)!)

	cashflow_min:=spreadsheet.float_repr(cashflow.min(),.number)

	println("\nThe lowest cash level over the years: ${cashflow_min}\n")

}

fn main() {

	mut cmd := Command{
		name: 'bizplanner'
		description: 'Business Planning Tool'
		version: '1.0.0'
	}
	mut docgen_cmd := Command{
		name: 'gen'
		description: 'Generate a business plan'
		usage: '<client_path>'
		required_args: 1
		execute: run_planner
	}
	docgen_cmd.add_flag(Flag{
		flag: .string
		required: false
		name: 'dest'
		abbrev: 'd'
		description: 'Destination where to generate.'
	})

	cmd.add_command(docgen_cmd)
	cmd.setup()
	cmd.parse(os.args)

	// do() or { panic(err) }
}
