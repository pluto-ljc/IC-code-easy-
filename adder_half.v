/*--------------------------------------------------------------------------------
--  File          :  adder_half.v
--  Related Files :
--  Author(s)     :  ljc
--  Email         :  lijiacehnguestc@gmail.com
--  Project       :   
--  Creation Date :  10.30.2020
--  Contents      :  一个非常简单的半加器
--------------------------------------------------------------------------------*/
module adder_half(  
	input		     	a,
	input				b,
	output	    reg		sum,
	output	    reg		cout
	);
	
always @(*)
begin
	sum = a ^ b;
	cout = a & b;
end
endmodule
