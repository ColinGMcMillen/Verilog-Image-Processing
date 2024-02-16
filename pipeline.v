//Image processing Verilog script
//Colin McMillen


//Read image into memory using script
//Capture the image as a series of 24 bit RGB values
//Alter those RGB values through processing
//Read those back into the memory file
//Re-display the image by writing that memory file

//#RRGGBB hex codes 24 bit color depth only

// operation: 
// 1 : brightness increase
// 2 : darkness increase
// 3 : invert image 
// 4 : add red tint
// 5 : add green tint
// 6 : add blue tint


module processing(clk, rst, operation);
  
  
  parameter pixelSize = 393216,
            WIDTH = 768,  //image width, easy to adjust for different sizes
            HEIGHT = 512, //image height, easy to adjust for different sizes
            ZERO = 0,
            ONE = 1,
            BIV = 50, // brightness increase value, easy to adjust
            BDV = 20; // brightness decrease value, easy to adjust
  
  
  
  input       clk;                  // module is synchronous
  input       rst;                  // synchronous reset (always low unless otherwise stated)
  input[2:0]  operation;       // operation input will be used to select operation on image
  reg[7:0]    redValue;   // red component
  reg[7:0]    blueValue;  // blue component
  reg[7:0]    greenValue; // green component
  
    
  
  //try and implement a block RAM here
  
  reg[23:0]MEM[0:pixelSize-1];     // making the memory for the list file

  
  initial begin 
    $readmemh("imageHex.hex",processing.MEM);   //read in the file, after this, start to alter the values given a specific input  
  end
  
  
 
reg[19:0] counter; //19 bit counter to cover all 392,216 pixels in the image
reg [7:0] BMP_header[0:53]; // for the header of the BMP image
reg done;



//Pipeline Registers
reg [7:0] redValue2 ,greenValue2, blueValue2; // we want to parse new pixel data at the same time that we process old pixel data


    always@(posedge clk) begin
    if(rst) begin
    counter = ZERO;
    done = ZERO;    
      end
    else begin
      if(counter <= pixelSize-1) counter = counter + 1; // update the counter at every clock pulse
      if(counter == pixelSize-1) done = ONE;
      end  // on the posedge of every clock, regs need to be reading pixel data

      
  end


 
integer file;  //For the output file
integer i;     //For the output loop
integer j;     //For the output loop


initial begin
 file = $fopen("out.bmp", "wb+");    // open file for writing in binary mode, reading and writing in case

i = ZERO;
j = ZERO;  
BMP_header[ 0] = 66;BMP_header[28] = 24; 
BMP_header[ 1] = 77;BMP_header[29] = 0; 
BMP_header[ 2] = 54;BMP_header[30] = 0; 
BMP_header[ 3] = 0;BMP_header[31] = 0;
BMP_header[ 4] = 18;BMP_header[32] = 0;
BMP_header[ 5] = 0;BMP_header[33] = 0; 
BMP_header[ 6] = 0;BMP_header[34] = 0; 
BMP_header[ 7] = 0;BMP_header[35] = 0; 
BMP_header[ 8] = 0;BMP_header[36] = 0; 
BMP_header[ 9] = 0;BMP_header[37] = 0; 
BMP_header[10] = 54;BMP_header[38] = 0; 
BMP_header[11] = 0;BMP_header[39] = 0; 
BMP_header[12] = 0;BMP_header[40] = 0; 
BMP_header[13] = 0;BMP_header[41] = 0; 
BMP_header[14] = 40;BMP_header[42] = 0; 
BMP_header[15] = 0;BMP_header[43] = 0; 
BMP_header[16] = 0;BMP_header[44] = 0; 
BMP_header[17] = 0;BMP_header[45] = 0; 
BMP_header[18] = 0;BMP_header[46] = 0; 
BMP_header[19] = 3;BMP_header[47] = 0;
BMP_header[20] = 0;BMP_header[48] = 0;
BMP_header[21] = 0;BMP_header[49] = 0; 
BMP_header[22] = 0;BMP_header[50] = 0; 
BMP_header[23] = 2;BMP_header[51] = 0; 
BMP_header[24] = 0;BMP_header[52] = 0; 
BMP_header[25] = 0;BMP_header[53] = 0; 
BMP_header[26] = 1; BMP_header[27] = 0; 
    
 
    
    $fwrite(file, "%c", BMP_header[0]); $fwrite(file, "%c", BMP_header[1]);
    $fwrite(file, "%c", BMP_header[2]); $fwrite(file, "%c", BMP_header[3]);
    $fwrite(file, "%c", BMP_header[4]); $fwrite(file, "%c", BMP_header[5]);
    $fwrite(file, "%c", BMP_header[6]); $fwrite(file, "%c", BMP_header[7]);
    $fwrite(file, "%c", BMP_header[8]); $fwrite(file, "%c", BMP_header[9]);
    $fwrite(file, "%c", BMP_header[10]); $fwrite(file, "%c", BMP_header[11]);
    $fwrite(file, "%c", BMP_header[12]); $fwrite(file, "%c", BMP_header[13]);
    $fwrite(file, "%c", BMP_header[14]); $fwrite(file, "%c", BMP_header[15]);
    $fwrite(file, "%c", BMP_header[16]); $fwrite(file, "%c", BMP_header[17]);
    $fwrite(file, "%c", BMP_header[18]); $fwrite(file, "%c", BMP_header[19]);
    $fwrite(file, "%c", BMP_header[20]); $fwrite(file, "%c", BMP_header[21]);
    $fwrite(file, "%c", BMP_header[22]); $fwrite(file, "%c", BMP_header[23]);
    $fwrite(file, "%c", BMP_header[24]); $fwrite(file, "%c", BMP_header[25]);
    $fwrite(file, "%c", BMP_header[26]); $fwrite(file, "%c", BMP_header[27]);
    $fwrite(file, "%c", BMP_header[28]); $fwrite(file, "%c", BMP_header[29]);
    $fwrite(file, "%c", BMP_header[30]); $fwrite(file, "%c", BMP_header[31]);
    $fwrite(file, "%c", BMP_header[32]); $fwrite(file, "%c", BMP_header[33]);
    $fwrite(file, "%c", BMP_header[34]); $fwrite(file, "%c", BMP_header[35]);
    $fwrite(file, "%c", BMP_header[36]); $fwrite(file, "%c", BMP_header[37]);
    $fwrite(file, "%c", BMP_header[38]); $fwrite(file, "%c", BMP_header[39]);
    $fwrite(file, "%c", BMP_header[40]); $fwrite(file, "%c", BMP_header[41]);
    $fwrite(file, "%c", BMP_header[42]); $fwrite(file, "%c", BMP_header[43]);
    $fwrite(file, "%c", BMP_header[44]); $fwrite(file, "%c", BMP_header[45]);
    $fwrite(file, "%c", BMP_header[46]); $fwrite(file, "%c", BMP_header[47]);
    $fwrite(file, "%c", BMP_header[48]); $fwrite(file, "%c", BMP_header[49]);
    $fwrite(file, "%c", BMP_header[50]); $fwrite(file, "%c", BMP_header[51]);
    $fwrite(file, "%c", BMP_header[52]); $fwrite(file, "%c", BMP_header[53]);

 end
 
 
 // Read the hex code, process that hex code, write the hex code back to memory, increment the counter
 //could be an issue with ontinously still doing the state mahcine even after all the hex codes have been changed
 always@(posedge clk)begin
  
 redValue <= MEM[counter][23:16];   // parse these values from the list file 
 greenValue <= MEM[counter][15:8];  
 blueValue <= MEM[counter][7:0]; 
   
 end
 
always@(posedge clk)begin
//update new register values with old values from previous always block to allow old regs to reprase new data instead of waiting
redValue2     <= redValue;  //pipeline
greenValue2   <= greenValue;  //pipeline
blueValue2    <= blueValue;    //pipeline

//Implement case statements to remove multiplexer trees


//Brightness Increase
if(operation == 1)begin
if(redValue2 + BIV >= 255)begin
  redValue2 = 255;
end
else redValue2 = redValue2 + BIV;
if(greenValue2 + BIV >= 255)begin
  greenValue2 = 255;
end
else greenValue2 = greenValue2 + BIV;
if(blueValue2 + BIV >= 255)begin
  blueValue2 = 255;
end
else blueValue2 = blueValue2 + BIV;
end


//Darkness Increase
if(operation == 2) begin
if(redValue2 - BDV < 0)begin
  redValue2 = 0;
end
else redValue2 = redValue2 - BDV;
if(greenValue2 - BDV < 0)begin
  greenValue2 = 0;
end
else greenValue2 = greenValue2 -BDV;
if(blueValue2 - BDV < 0)begin
  blueValue2 = 0;
end
else blueValue2 = blueValue2 - BDV;
end

//inversion 
if(operation == 3)begin
redValue2 = 255-redValue2;
blueValue2 = 255-blueValue2;
greenValue2 = 255-greenValue2;  
end




MEM[counter][23:16] <= redValue2;     //rewrite to memory
MEM[counter][15:8]  <= greenValue2;   //rewrite to memory
MEM[counter][7:0]   <= blueValue2;    //rewrite to memory

end
    

//Write to output file when MEM processing is finished
always @(done) begin
  if (done == 1) begin
    for (j = HEIGHT - 1; j >= 0; j = j - 1) begin
      for (i = 0; i <= WIDTH - 1; i = i + 1) begin
        $fwrite(file, "%c%c%c", MEM[i*HEIGHT + j][7:0], MEM[i*HEIGHT + j][15:8], MEM[i*HEIGHT + j][23:16]);
      end
    end
  end
end

  
 
endmodule












module processing_tb;
  reg clk, rst;
  reg[2:0] op;
  
  
  processing dut(clk, rst, op); //not using hsync, remove later
  
  initial begin
    // generate a .vcd file to see all changes
   // $dumpfile("dump.vdc");
   // $dumpvars(0, processing_tb);
   // $dumpoff;
   // $dumpon;
    
    clk = 0;  // start clk
    rst = 1;  // start rst to get counter started
    op = 1; // brighness increase
    #10;  // wait 10 
    rst = 0;  // remove the reset
   // $display("%p", processing_tb.dut.MEM);
  
    #800000 // simulation timing
    //$dumpoff;
 

    $stop;
    
  end
  
  always #1 clk = ~clk;
  
endmodule
  
  

  
  
  
  
  


