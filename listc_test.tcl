source listc.tcl

proc listc_test { t_list_expected t_listc } {

	if { $t_listc != $t_list_expected } {
		puts "<t_list_expected : $t_list_expected>"
		puts "<t_listc         : $t_listc>"
		puts ""
		error "Output of list comprehension doesn't match expected output."
	}

	return 1

}

# Empty list #1
set t_list_expected [list]
set t_listc         [listc]
if {[listc_test $t_list_expected $t_listc]} {
	puts "Test 1 passed."
}

# Empty list #2
set t_list_expected [list]
set t_listc         [listc x]
if {[listc_test $t_list_expected $t_listc]} {
	puts "Test 2 passed."
}

# Single item list
set t_list_expected [list 1]
set t_listc         [listc x [list 1 1]]
if {[listc_test $t_list_expected $t_listc]} {
	puts "Test 3 passed."
}

# Numbers from 1 to 10 inclusive
set t_list_expected [list 1 2 3 4 5 6 7 8 9 10]
set t_listc         [listc x [list 1 10]]
if {[listc_test $t_list_expected $t_listc]} {
	puts "Test 4 passed."
}

# Squares of numbers 1 to 5 inclusive
set t_list_expected [list 1 4 9 16 25]
set t_listc         [listc x**2 [list 1 5]]
if {[listc_test $t_list_expected $t_listc]} {
	puts "Test 5 passed."
}

# Odd numbers between 1 and 10 inclusive
set t_list_expected [list 1 3 5 7 9]
set t_listc         [listc x [list 1 10] x%2==1]
if {[listc_test $t_list_expected $t_listc]} {
	puts "Test 6 passed."
}

# Even numbers between 1 and 60 inclusive where x > 50
set t_list_expected [list 52 54 56 58 60]
set t_listc         [listc x [list 1 60] x>50&&x%2==0]
if {[listc_test $t_list_expected $t_listc]} {
	puts "Test 7 passed."
}

# Numbers between 0 and 1 inclusive in increments of a tenth
set t_list_expected [list 0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0]
set t_listc         [listc x/10.0 [list 0 10]]
if {[listc_test $t_list_expected $t_listc]} {
	puts "Test 8 passed."
}

# Fibonacci sequence from 0 to 10 inclusive
proc fib {val} {
	switch -- $val {
		0       {return 0}
		1       {return 1}
		default {return [expr { [fib [expr { $val - 1 }]] + [fib [expr { $val - 2 }]] }]}
	}
}
set t_list_expected [list 0 1 1 2 3 5 8 13 21 34 55]
set t_listc         [listc {[fib x]} [list 0 10]]
if {[listc_test $t_list_expected $t_listc]} {
	puts "Test 9 passed."
}

# Squares of numbers from 15 to 20 inclusive for variable name y where 2y > 32
set t_list_expected [list 289 324 361 400]
set t_listc         [listc y**2 [list 15 20] y*2>32 y]
if {[listc_test $t_list_expected $t_listc]} {
	puts "Test 10 passed."
}
