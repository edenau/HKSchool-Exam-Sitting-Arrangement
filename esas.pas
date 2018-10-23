program ESAS;
 uses crt;

var back : boolean;
option : char;
ele_short : array[1..21] of string; 
ele_full : array[1..21] of string;  
ele_cnt : integer;     

avail : array[1..21] of boolean;

list_ori : array[1..21] of integer;
list_new : array[1..21] of integer;

ref , times: longint;
po1 , po2 : longint;

list_final : array[0..21] of integer;

timeko , compare , ready : boolean;
crash : array['4'..'6' , 1..21 , 1..21] of integer;

ele_time : array[1..21] of integer;

procedure mod_sub;
var option_1_2 , option_1_2_1 , option_1_2_3 , option_1_2_2: char;
back_1_2 , back_1_2_1 , back_1_2_3 , back_1_2_2 , back_1_2_2_sure : boolean;
temp_short : string[4];
temp_full : string;
temp , num : integer;
begin
  back_1_2 := false;
  
  repeat
  
  writeln('SUBJECT MODIFICATION');
  writeln('1 Add an Elective Subject');
  writeln('2 Delete an Elective Subject');
  writeln('3 Delete All Subjects');
  writeln('9 Back to Previous Stage');
  writeln('0 Back to Main Menu');
  writeln;
  
  write('Please Select : ');
  readln(option_1_2);
  writeln;
  
  case option_1_2 of
  '1' : 
    begin 
      back_1_2_1 := false;
      
      repeat
      writeln('Input the short form of new subject');
      write('[all English characters with maximum no. of character of 4] : ');
      readln(temp_short);
      
      write('Input the full form of new subject : ');
      readln(temp_full);
      
      writeln;
      
      writeln('The following subject will be added : ');
      write(temp_short);
      for temp := 1 to 5-length(temp_short) do
          write(' ');
      writeln(temp_full);
      
      writeln;
      
        repeat
        write('Are you sure? [S for sure, C for cancel] : ');
        readln(option_1_2_1);
        
        writeln;
             
        
        case option_1_2_1 of
        'S' , 's' : 
          begin
            ele_cnt := ele_cnt + 1;
            ele_short[ele_cnt] := temp_short;
            ele_full[ele_cnt] := temp_full;
          
            back_1_2_1 := true;
          
            writeln('Subject added successfully!');
            writeln;
          end;
        'C' , 'c' : 
          begin
            back_1_2_1 := true;

            writeln('Process cancelled successfully!');
            writeln;
          end;
        else 
          begin
            writeln('Wrong input!');
            writeln;
            back_1_2_1 := false;        
          end;
        end;
        
        until back_1_2_1;
          
      until back_1_2_1;
      
    end;
  '2' :
    begin
     
      writeln('[Format : ''Short-term'' ''Full-name'']');
      
      writeln;
      
      if ele_cnt = 0 then
        writeln('<There are no subjects available>') else   
        begin
          for num := 1 to ele_cnt do
          begin
            write(ele_short[num]);
            for temp := 1 to 5-length(ele_short[num]) do
              write(' ');
            writeln(ele_full[num]);       
          end;
      
        writeln;
      
        repeat
        
        writeln('Which subject do you want to delete?');
        write('Input the short-term of that subject : ');
        readln(temp_short);
        
        back_1_2_2 := false;
        
        write('[S for sure, C for cancel] : ');
        readln(option_1_2_2);
        
        writeln;
        
        case option_1_2_2 of
        'S' , 's' : back_1_2_2 := true;

        'C' , 'c' :
        begin
          back_1_2_2 := true;
         
          writeln('Process cancelled successfully!');
          writeln;          
        end;
        
        else 
          begin
            writeln('Wrong input!');
            writeln;      
          end;
        end;
        
        until back_1_2_2; 
        
        if (option_1_2_2 = 'S') or (option_1_2_2 = 's') then
        begin
          back_1_2_2_sure := false;
          for temp := 1 to ele_cnt do
            if ele_short[temp] = temp_short then
            begin
              ele_short[temp] := ele_short[ele_cnt];
              ele_full[temp] := ele_full[ele_cnt];
              ele_cnt := ele_cnt - 1;
              back_1_2_2_sure := true;
              
              break;
            end;
        
          if not back_1_2_2_sure then
            begin
              writeln('No matches found!');                    
              writeln;
            end else
            begin
              writeln('Subject deleted successfully!');
              writeln;
            end;
         
          end;
        end;
    end;
                                    
  '3' : 
    begin
      repeat
        back_1_2_3 := false;
        
        writeln('Are you sure to delete all subjects?');
        write('[S for sure, C for cancel] : ');
        readln(option_1_2_3);
        
        writeln;
        
        case option_1_2_3 of
        'S' , 's' : 
          begin
            back_1_2_3 := true;
            
            ele_cnt := 0;
            // number of subject now is set to be zero
            
            writeln('All subjects deleted successfully!');
            writeln;
          end;
        'C' , 'c' :
        begin
          back_1_2_3 := true;
          
          writeln('Process cancelled successfully!');
          writeln;
        end
        else 
          begin
            writeln('Wrong input!');
            writeln;      
          end;
        end;
        
        until back_1_2_3;
    
    end;  
  '9' : back_1_2 := true;
  '0' : back := true
  else writeln('Wrong input!')
  end;
  
  until back or back_1_2;

end;                           



procedure update_setting;
var option_1 : char;
all_sub : text;                    
comma_pos , num , temp : integer;     

begin
  writeln('Loading...importing file ''all_sub.csv''');
  writeln;
  
  assign(all_sub , 'all_sub.csv');
  reset(all_sub);
  
  ele_cnt := 0;      
  while not eof(all_sub) do
  begin
    ele_cnt := ele_cnt + 1;
    readln(all_sub , ele_full[ele_cnt]);
    comma_pos := pos(',' , ele_full[ele_cnt]);
    
    ele_short[ele_cnt] := copy(ele_full[ele_cnt] , 1 , comma_pos - 1);
    ele_full[ele_cnt] := copy(ele_full[ele_cnt] , comma_pos + 1 , length(ele_full[ele_cnt]) - comma_pos);
  end;
  
  close(all_sub);

  repeat                            
  
  writeln('BASIC SETTING');
  writeln('1 Show Current Elective Subjects Available');
  writeln('2 Modify Subjects Available');
  writeln('0 Back to Main Menu');
  writeln;
  
  write('Please Select : ');
  readln(option_1);
  writeln;
  
  case option_1 of
  '1' :
    begin      
      writeln('[Format : ''Short-term'' ''Full-name'']');
      
      writeln;
      
      if ele_cnt = 0 then
        writeln('<There are no subjects available>') else   
        for num := 1 to ele_cnt do
        begin
          write(ele_short[num]);
          for temp := 1 to 5-length(ele_short[num]) do 
            write(' ');
          writeln(ele_full[num]);       
        end;
      
      writeln;
      
    end;
  '2' : mod_sub;
  '0' : back := true
  else writeln('Wrong input!')
  end;
  
  until back;
  
  assign(all_sub , 'all_sub.csv'); 
  rewrite(all_sub);
  for temp := 1 to ele_cnt do
    writeln(all_sub , ele_short[temp] , ',' , ele_full[temp]);
  close(all_sub);
  
  writeln('''all_sub.csv'' is the basic setting for your reference');
  writeln('Database of basic setting is updated automatically');
  writeln;
  
end;

procedure conversion;

var all_info , rec : text;
temp : string;
cnt , cnt2 : integer;

form , cls : char;
cls_no , err : integer;

name : array['4'..'6' , 'A'..'E' , 1..45] of string;   
no_sub : array['4'..'6' , 'A'..'E' , 1..45] of integer; 
sub : array['4'..'6' , 'A'..'E' , 1..45 , 1..4] of string;

begin
  back := false;
  
  writeln('Put all student''s information into file named ''ele_list.csv''');
  writeln('Press Enter to continue if you saved the file');
  writeln('Or input something for leave');
  readln(temp);
  writeln;
  
  if temp = '' then
  begin
    for form := '4' to '6' do
    for cls := 'A' to 'E' do
    for cls_no := 1 to 45 do
    begin
      no_sub[form , cls , cls_no] := 0;
      name[form , cls , cls_no] := '';
      for cnt := 1 to 4 do
        sub[form , cls , cls_no , cnt] := '';
  
    end;
  
  
    assign(all_info , 'ele_list.csv');
    reset(all_info);
    while not eof(all_info) do
    begin
      readln(all_info , temp);
    
      form := temp[1];
      cls := temp[2];
    
      if temp[5] = ',' then
        begin
          val(temp[4] , cls_no , err);
          delete(temp,1,5);
        end else
        begin     
          val(temp[4] + temp[5] , cls_no , err);
          delete(temp,1,6);
        end;
    
      if no_sub[form , cls , cls_no] = 0 then
        for cnt := 1 to pos(',' , temp) - 1 do
        name[form , cls , cls_no] := name[form , cls , cls_no] + temp[cnt];
        
      no_sub[form , cls , cls_no] := no_sub[form , cls , cls_no] + 1;
      for cnt := pos(',' , temp) +1 to length(temp) do
      sub[form , cls , cls_no , no_sub[form , cls , cls_no] ] := sub[form , cls , cls_no , no_sub[form , cls , cls_no] ] + temp[cnt];
    
    end;
  
    close(all_info);
  
    
    for form := '4' to '6' do
    begin
      assign(all_info , 'stu_info_' + form + '.csv');
      assign(rec , 'sub_rec_' + form + '.ini');
      rewrite(all_info);
      rewrite(rec);
      for cls := 'A' to 'E' do
      for cls_no := 1 to 45 do
        if no_sub[form , cls , cls_no] > 0 then
        begin
          write(all_info , form , ',' , cls , ',' , cls_no , ',' , name[form , cls , cls_no]);
        
          for cnt := 1 to no_sub[form , cls , cls_no] do
          write(all_info , ',' , sub[form , cls , cls_no , cnt]);
        
          writeln(all_info);
          
          // 
          
          for cnt := 1 to ele_cnt do
            for cnt2 := 1 to 4 do
              if ele_short[cnt] = sub[form , cls , cls_no , cnt2] then
              begin
                write(rec , '1');
                break;
              end else
              if cnt2 = 4 then
                write(rec , '0');
          
          writeln(rec);
        end else
           break;
      close(all_info);
      close(rec);
    end;
    
    compare := true;
    writeln('Student information analyzed');
    writeln('''stu_info_4.csv'' , ''stu_info_5.csv'' , ''stu_info_6.csv'' are');
    writeln('tidied files of student information for each form respectively');
    writeln;
  
  end;
           
end;

procedure exam_info;
var cnt : integer;

option_3 : char;
back_3 : boolean;
temp , temp0 : string;
sub_time : text;
begin
  writeln('Press Enter to continue for updating exam information');
  writeln('Or input something for leave');
  readln(temp0);
  writeln;
  
  if temp0 = '' then
  begin
    writeln('Write down the time (in minutes) needed for each subject''s exam:');
    writeln;
  
    for cnt := 1 to ele_cnt do
    begin
      write(ele_full[cnt] , ' : ');
      readln(ele_time[cnt]); 
      writeln;
    end;
  
    repeat
  
    for cnt := 1 to ele_cnt do
      writeln(ele_short[cnt]:5 , '  ' , ele_time[cnt]);
    writeln;
  
    write('Are you sure? [S for sure, A for amendment] : ');
    readln(option_3);
      
    writeln;
             
        
    case option_3 of
    'S' , 's' : 
      begin  
        back_3 := true;
        
        writeln('Exam information updated successfully!');
        writeln;
      end;
    'A' , 'a' : 
      begin
      repeat
      writeln('Input nothing to exit, or');
      write('Input the short form of subject you want to amend the time needed : ');
      readln(temp);
      writeln;
        
      if temp <> '' then
      begin
        for cnt := 1 to ele_cnt do
        if temp = ele_short[cnt] then
          break;
     
        if (cnt = ele_cnt) and (temp <> ele_short[ele_cnt]) then
          writeln('Wrong input!') else
          begin
            write(ele_full[cnt] , ' : ');
            readln(ele_time[cnt]);
            writeln('Time updated successfully!');
            writeln;
          end;
      end;
        
    until temp = '';
      
        back_3 := false;      
      end;
    else 
      begin
        writeln('Wrong input!');
        writeln;
        back_3 := false;        
      end;
    end;
       
    until back_3;
  
    assign(sub_time , 'sub_time.csv');
    rewrite(sub_time);
  
    for cnt := 1 to ele_cnt do
      writeln(sub_time , ele_short[cnt] , ',' , ele_time[cnt]);
  
    close(sub_time);  
    writeln('''sub_time.csv'' updated.');
    writeln;
    
    timeko := true;
  end;
end;

function  coeff(form : char ; newbie : boolean) : longint;
// for calculating coefficient of a subject queue
var cnt , cnt2 : integer;
begin
  coeff := 0;
  for cnt := 1 to ele_cnt - 1 do
  for cnt2 := cnt + 1 to ele_cnt do
  if newbie then
    if list_new[cnt] < list_new[cnt2] then
    coeff := coeff + (ele_cnt-(cnt2-cnt)) * crash[form , list_new[cnt] , list_new[cnt2]] else
    coeff := coeff + (ele_cnt-(cnt2-cnt)) * crash[form , list_new[cnt2] , list_new[cnt]] else
    if list_ori[cnt] < list_ori[cnt2] then 
    coeff := coeff + (ele_cnt-(cnt2-cnt)) * crash[form , list_ori[cnt] , list_ori[cnt2]] else
    coeff := coeff + (ele_cnt-(cnt2-cnt)) * crash[form , list_ori[cnt2] , list_ori[cnt]];
end;    

procedure arrange;
var rec , tt : text;
cnt , cnt2  , cnt3 : integer;
temp : string;
temp1 , tries : integer;
form : char;
stop : boolean;

begin
  writeln('Press Enter to continue for exam arrangement');
  writeln('Or input something for leave');
  readln(temp);
  writeln;
  
  for form := '4' to '6' do
  for cnt := 1 to 21 do
  for cnt2 := 1 to 21 do
  crash[form , cnt , cnt2] := 0;  
  
  if temp = '' then
  begin
    for form := '4' to '6' do
    begin
      assign(rec , 'sub_rec_' + form + '.ini');
      reset(rec);
      
      repeat
      readln(rec , temp);
      for cnt := 1 to ele_cnt-1 do
      for cnt2 := cnt+1 to ele_cnt do
        if (temp[cnt] = '1') and (temp[cnt2] = '1') then
          crash[form , cnt , cnt2] := crash[form , cnt , cnt2] + 1;  
      until eof(rec);
      close(rec);
    end;
     // all crash comparison data is stored in (crash) array
    for form := '4' to '6' do
    begin 
      tries := 0;
      repeat
      tries := tries + 1;
      
      for cnt := 1 to ele_cnt do
      avail[cnt] := true;
      if tries = 1 then
        randomize;
      for cnt := 1 to ele_cnt do
      begin
        list_ori[cnt] := random(ele_cnt) + 1;
        while not avail[list_ori[cnt]] do
        begin
          list_ori[cnt] := list_ori[cnt] + 1;
          if list_ori[cnt] > ele_cnt then
            list_ori[cnt] := 1;
        end;
        avail[list_ori[cnt]] := false;
      end;
      // for making a random queue at first      
      times := 0;
      repeat
      times := times + 1;
      
      ref := coeff(form,false);
      stop := true;    
      
      for cnt := 1 to ele_cnt - 1 do
      for cnt2 := cnt + 1 to ele_cnt do
      begin
        for cnt3 := 1 to ele_cnt do
          list_new[cnt3] := list_ori[cnt3];
        temp1 := list_new[cnt];
        list_new[cnt] := list_new[cnt2];
        list_new[cnt2] := temp1;
        
        if coeff(form,true) < ref then
        begin
          ref := coeff(form,true);
          po1 := cnt;
          po2 := cnt2;
        end;
      end;
      
      if ref < coeff(form,false) then
      begin
        stop := false;
        
        temp1 := list_ori[po1];
        list_ori[po1] := list_ori[po2];
        list_ori[po2] := temp1;
      end;
      // try to swap two subjects to find whether a more optimum case exists or not
      until stop or (times = 100);
      // to prevent nearly infinte looping (but that is almost impossible, just to secure)   
      if tries = 1 then
        list_final[0] := ref + 1;
        // to find something for comparison in the first compare tries (since there is no original datum for the first compare try)     
      if ref < list_final[0] then
      begin
       list_final[0] := ref;
        for cnt := 1 to ele_cnt do
          list_final[cnt] := list_ori[cnt];
      end;

      until tries = 10;
      // loop 10 tries for finding the optimum solution
      
      assign(tt , 'timetable_' + form + '.txt');
      rewrite(tt);
      for cnt := 1 to ele_cnt do
        writeln(tt , ele_short[list_final[cnt]]);
      close(tt);      
    end;           
  
  writeln('''timetable_4.txt'' , ''timetable_5.txt'' , ''timetable_6.txt'' updated.');
  writeln;
  
  ready := true;
  
  end;
end;

procedure seat;
var stud , rec , allo , watch : text;
temp , term , temp1 , state , temp3 , temp2 : string;
prepare : array[1..4] of string;
fin : array[1..4] of string;
t : array[1..4] of string;
spec : string[6];
cnt , ano , accu , pre_no , fin_no , thr : integer;
form : char;
begin
  writeln('Press Enter to continue for seat allocation');
  writeln('Or input something for leave');
  readln(temp);
  writeln;
  
  if temp = '' then
  begin
    for form := '4' to '6' do
    begin
      assign(stud , 'stu_info_' + form + '.csv');
      assign(rec , 'sub_rec_' + form + '.ini');
      
      for cnt := 1 to ele_cnt do
      begin
        accu := 0;
        writeln('Updating ' , ele_short[cnt] + '_' + form + '.csv');        
        
        assign(allo , '.\seat_allocation\' + form + '\' + ele_short[cnt] + '_' + form + '.csv');
        rewrite(allo);        
        reset(stud);
        reset(rec);
        
        writeln(allo , 'Seat no.,Form,Class,Class no.,Name');
        
        repeat
        readln(rec , term);
        if term[cnt] = '1' then
        begin
          accu := accu + 1;
          readln(stud , temp1);
          write(allo , accu);
          for ano := 1 to 4 do
          begin
            write(allo , ',' , copy(temp1 , 1 , pos(',' , temp1) - 1));
            delete(temp1 , 1 , pos(',' , temp1));          
          end;
          writeln(allo);
        end else
          readln(stud);
        until eof(rec);
        
          
        close(allo);
      end;
    
    close(stud);
    close(rec);    
    end;
    
    writeln('Loading... Please wait patiently');    
          
    for form := '4' to '6' do 
    begin
      assign(stud , 'stu_info_' + form + '.csv');
      assign(rec , 'sub_rec_' + form + '.ini');
          
      reset(stud);
      reset(rec);
      
      repeat
      
      pre_no := 0;
      
      readln(stud , spec);
      if spec[6] = ',' then
        state := spec[1]+spec[3]+'0'+spec[5] else
        state := spec[1]+spec[3]+spec[5]+spec[6];
        
      assign(allo , '.\seat_allocation\personal\' + state + '.csv');
      rewrite(allo);
  
      readln(rec , temp2);
      
      for cnt := 1 to ele_cnt do
      if temp2[cnt] = '1' then
      begin
        assign(watch , '.\seat_allocation\' + form + '\' + ele_short[cnt] + '_' + form + '.csv');
        reset(watch);
        repeat
        readln(watch , temp3);
        until pos(spec , temp3) <> 0;
      
        pre_no := pre_no + 1;
        prepare[pre_no] := ele_short[cnt] + ',' + copy(temp3 , 1 , pos(',',temp3) - 1);
        
        close(watch);
      end;
      
      fin_no := 0;
      for cnt := 1 to ele_cnt do
      for thr := 1 to pre_no do
      if pos(ele_short[list_final[cnt]] , prepare[thr]) <> 0 then
      begin
        fin_no := fin_no + 1;
        str(cnt , t[fin_no]);
        fin[fin_no] := t[fin_no] + ',' + prepare[thr] + ',' ;
        str(ele_time[list_final[cnt]] , t[fin_no]);
        fin[fin_no] := fin[fin_no] + t[fin_no];
        break;
      end;
      
      writeln(allo , 'Day,Subject,Seat no.,Duration');
      for thr := 1 to fin_no do
        writeln(allo , fin[thr]);
      
      close(allo);
      until eof(rec);
          
    close(stud);
    close(rec); 
    end;
    
    writeln;
    writeln('All work done!');
    writeln;
      
  end;  
end;

begin
  back := false;
  timeko := false;
  compare := false;
  ready := false;
  writeln('School Internal Examination Sitting Arrangement System (ESAS)');
  writeln;
  
  writeln('You should import the subject available in ''all_sub.csv'' first');
  writeln;
  
  repeat                            
  
  writeln('MAIN MENU'); 
  writeln('1 Update Setting');
  writeln('2 Update Student Information');
  writeln('3 Update Information of Each Exam Paper (Time of each paper)');
  writeln('4 Arrange Exam');
  writeln('5 Allocate Seat and Produce Final Arrangement');
  writeln('0 Exit');
  writeln;
  
  write('Please Select : ');
  readln(option);
  writeln;
  
  case option of
  '1' : update_setting;
  '2' : if ele_cnt = 0 then
          writeln('Update basic setting first!')  else  
          conversion;
  '3' : if not compare then
          writeln('Update student information first!')  else
          exam_info; 
  '4' : if not timeko then
          writeln('Update information of each exam paper first!')  else
          arrange;
  '5' : if not ready then
          writeln('Arrange exam first!')  else
          seat;
  '0' : back := true                                
  else writeln('Wrong input!')
  end;
  
  if option = '0' then
    back := true else
    back := false;
  
  until back;
  
  writeln('Press Enter to close.');
  readln;
end.
