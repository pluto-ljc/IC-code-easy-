/*--------------------------------------------------------------------------------
--  File          :  sn_detector.v
--  Related Files :
--  Author(s)     :  ljc
--  Email         :  lijiacehnguestc@gmail.com
--  Project       :   
--  Creation Date :  10.30.2020
--  Contents      :  序列检测器：10010
--------------------------------------------------------------------------------*/

module sn_detector (
  input       rst_n,
  input       clk,
  input       sn_i,
  output reg  sn_check_o 
				  ) ;

 reg   [2:0]     curr_state ;
 reg   [2:0]     Next_state ;
 
parameter		  st_idle  = 3'd0,					//对应原始状态 
         			st_1     = 3'd1,					//对应起始状态1 
  		        st_10    = 3'd2,					//对应中间状态10 
  		        st_100   = 3'd3,					//对应中间状态100
  		        st_1001  = 3'd4,					//对应中间状态1001
              st_10010 = 3'd5;

//第一部分：描述next_state的组合逻辑
always @(*)
begin
  case(curr_state)
   st_idle:
     if (sn_i==1)
       Next_state = st_1; 
     else
       Next_state = st_idle;  
   st_1:
     if (sn_i==0)
       Next_state = st_10; 
     else
       Next_state = st_1;    
   st_10:
     if (sn_i==0)
       Next_state = st_100; 
     else
       Next_state = st_1;  
   st_100:
     if (sn_i==1)
       Next_state = st_1001; 
     else
       Next_state = st_idle;    
   st_1001:
     if (sn_i==1)
       Next_state = st_1; 
     else
       Next_state = st_10010;
   st_10010:
     if (sn_i==1)
       Next_state = st_1; 
     else
       Next_state = st_100;        
   default:
       Next_state = st_idle;    //缺省值
  endcase
end
 
//第二部分：生成curr_state的时序逻辑部分（D触发器）
always @(posedge clk or negedge rst_n)
begin
  if (!rst_n)
    curr_state <= 0;
  else
    curr_state <= Next_state;
end  
 
//第三部分：描述产生sn_check_o的组合逻辑和D触发器合为一个描述时序逻辑的always语句。 
always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)   
	  sn_check_o <= 1'b0;
	else if(curr_state==st_10010)
	  sn_checko <= 1'b1;
	else
	  sn_check_o <= 1'b0;
end

endmodule	

