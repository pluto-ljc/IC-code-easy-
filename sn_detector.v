/*--------------------------------------------------------------------------------
--  File          :  sn_detector.v
--  Related Files :
--  Author(s)     :  ljc
--  Email         :  lijiacehnguestc@gmail.com
--  Project       :   
--  Creation Date :  10.30.2020
--  Contents      :  ���м������10010
--------------------------------------------------------------------------------*/

module sn_detector (
  input       rst_n,
  input       clk,
  input       sn_i,
  output reg  sn_check_o 
				  ) ;

 reg   [2:0]     curr_state ;
 reg   [2:0]     Next_state ;
 
parameter		  st_idle  = 3'd0,					//��Ӧԭʼ״̬ 
         			st_1     = 3'd1,					//��Ӧ��ʼ״̬1 
  		        st_10    = 3'd2,					//��Ӧ�м�״̬10 
  		        st_100   = 3'd3,					//��Ӧ�м�״̬100
  		        st_1001  = 3'd4,					//��Ӧ�м�״̬1001
              st_10010 = 3'd5;

//��һ���֣�����next_state������߼�
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
       Next_state = st_idle;    //ȱʡֵ
  endcase
end
 
//�ڶ����֣�����curr_state��ʱ���߼����֣�D��������
always @(posedge clk or negedge rst_n)
begin
  if (!rst_n)
    curr_state <= 0;
  else
    curr_state <= Next_state;
end  
 
//�������֣���������sn_check_o������߼���D��������Ϊһ������ʱ���߼���always��䡣 
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

