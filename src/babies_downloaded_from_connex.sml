(*
Your name and student id
*)
structure Babies =
struct
local
  open Csc330
in
(* Function to compare strings, returns bool *)
fun compr (pr: string*string) = 
  if (#1 pr) <> (#2 pr)
  then false
  else true
fun sum_list (lst) = 
    if null lst
    then 0
    else valOf(hd lst) + sum_list(tl lst)
fun count_years (lst) = 
    if null lst
    then 0
    else if (valOf( hd lst) > 0) then 1 + count_years(tl lst)
    else count_years(tl lst)
fun last_val (lst) = 
    if null (tl lst)
    then lst
    else last_val(tl lst)
fun find_first (lst, pos) = 
    if null lst
    then (NONE, pos)
    else if valOf( hd lst) > 0 then (hd lst, pos)
    else find_first (tl lst, pos + 1)
fun reverse (x, z) = 
    if null x
    then z
    else reverse ( tl(x), hd(x)::z)
fun min (lst, counter) = 
    if null lst
    then (NONE, counter)
    else if valOf(hd lst) = 0 then min(tl lst, counter + 1)
    else 
        let
            val tl_ans = min(tl lst, counter + 1)
            in
                if isSome (#1 tl_ans) andalso valOf(#1 tl_ans) < valOf(hd lst)
                then (#1 tl_ans, #2 tl_ans)
                else (SOME (valOf(hd lst)), counter)
            end
fun max (lst, counter) = 
    if null lst
    then (NONE, counter)
    else
        let
            val tl_ans = max(tl lst, counter + 1)
            in
                if isSome (#1 tl_ans) andalso valOf(#1 tl_ans) >= valOf(hd lst)
                then (#1 tl_ans, #2 tl_ans)
                else (SOME (valOf(hd lst)), counter)
            end

fun print_data(lst, name, s_pos, s_year) = 
let
    val _ = print(""^name^"\n")

    (* Calculating all the information needed *)
    val total = sum_list (lst)
    val years = count_years (lst)
    val num_in_2019 = valOf (hd (last_val (lst)))
    
    val first_pr = find_first (lst, 0)
    val first_val = valOf (#1 first_pr)
    val f_year = (#2 first_pr + s_year)
    
    val last_pr = find_first (reverse(lst, []), 0)
    val last_val = valOf ( #1 last_pr)

    val last_year_num = s_year + length (lst) - 1

    val l_year = (last_year_num - #2 last_pr)
    

    val min_pr = min(lst, 0)
    val min_year = (#2 min_pr + s_year + s_pos)
    val min_val = valOf( #1 min_pr)

    val max_pr = max(lst, 0)
    val max_year = (#2 max_pr+s_year+s_pos)
    val max_val = valOf( #1 max_pr)

    val avg = int_to_real(total)/int_to_real(length lst)

(* Printing values for each name here *)
    val _ = print (" Total: "^int_to_string total^"\n")
    val _ = print (" Years: "^int_to_string years^"\n")
    val _ = print (" "^int_to_string last_year_num^": "^int_to_string num_in_2019^"\n")
    val _ = print (" First: "^int_to_string f_year^" "^int_to_string first_val^"\n")
    val _ = print (" Last: "^int_to_string l_year^" "^int_to_string last_val^"\n")
    val _ = print (" Min: "^int_to_string min_year^" "^int_to_string min_val^"\n")
    val _ = print (" Max: "^int_to_string max_year^" "^int_to_string max_val^"\n")
    val _ = print (" Avg: "^real_to_string avg^"\n")

in 
()
end

fun find_info(name, s_pos, lst, s_year) = 
  let

    val ch2 = #","
    fun extract_data(lst, s_pos, counter) = 
      if null (tl lst)
      then[]
      else if counter = s_pos then fromString(hd lst)::(extract_data(tl lst, s_pos, counter))
      else extract_data(tl lst, s_pos, counter+1)

    fun find_vals (inp, lst, s_pos) = 
      if null lst
      then []
      else if (compr (hd (split_at(hd lst, ch2)), name)) then extract_data (tl (split_at( hd lst, ch2)), s_pos, 0)
      else find_vals(inp, tl lst, s_pos)

    fun process(lst, name, s_pos, s_year) = 
        if null lst
        then print ("" ^name^"\nBaby name ["^name^"] was not found\n")
        else print_data(lst, name, s_pos, s_year)

    val dat = find_vals(name, lst, s_pos)
    val _ = process(dat, name, s_pos, s_year)

  in 
  ()
  end

(* Takes input as list of names, returns a list of strings with information *)
fun process_input(names, start_pos, li, s_year) = 
  if null names
  then []
  else find_info(hd names, start_pos, li, s_year)::process_input(tl names, start_pos, li, s_year)

fun print_first_line(li, year, s_pos) = 
let
    val ch = #","
    val head = hd li
    val total_len = length li
    val head_list = split_at(head, ch)
    val num_of_entries = int_to_string ( length(head_list) - 2 - s_pos)

    val _ = print ("Read "^int_to_string total_len^" babies"^dot^" Starting year "^year^""^dot^" Each baby has "^ num_of_entries^" entries"^dot^"\n")
in 
    ()
end

fun babies_program (fileName, yearSt) =
    let
      val ch = #"\n"
      val ch2 = #","
      
      val start_pos = 0
      val s_year = valOf (fromString yearSt)

      val data = read_file (fileName)
      val li = split_at(data, ch)

      val input = read_stdin()
      val input_names = split_at (input, ch)

      val _ = print_first_line(li, yearSt, start_pos)
      val _ = process_input (input_names, start_pos, li, s_year)

    in
      ()
    end
        
(*
do not modify below this point
*)
        
fun main (prog_name, args) =
    let
      val (_, fileName, offsetSt) = parse_command_line args
      val _ = babies_program(fileName, offsetSt)
    in
      exit()
    end

end

end
    
