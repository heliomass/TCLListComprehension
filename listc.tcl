proc listc { {expression {}} {input_set {}} {predicate {}} {variable_name x} } {

	# Empty list
	if {$expression eq {} || $input_set eq [list]} {
		return [list]
	}

	# Assume identity for expression if no expression supplied
	if {$expression eq {}} {
		set expression $variable_name
	}

	# Assume identity for predicate if no predicate supplied
	if {$predicate eq {}} {
		set predicate "$variable_name==${variable_name}"
	}

	# Initialise the list
	set generated_list [list]

	# Substitution pass
	set expression [string map [subst {$variable_name \${i}}] $expression]
	set predicate  [string map [subst {$variable_name \${i}}] $predicate]

	# Parse the input set
	set lower [lindex $input_set 0]
	set upper [lindex $input_set 1]
	set step  [expr { [llength $input_set] >= 3 ? [lindex $input_set 2] : 1 }]

	# Produce the list
	for {set i $lower} {$i <= $upper} {set i [expr { $i + $step }]} {
		if {[expr [subst {$predicate}]]} {
			lappend generated_list [expr [subst {$expression}]]
		}
	}

	return $generated_list

}

