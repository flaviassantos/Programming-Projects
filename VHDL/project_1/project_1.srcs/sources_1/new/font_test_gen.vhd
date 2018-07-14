library ieee; 
use ieee. std_logic_1164.all ;
use ieee. numeric_std.all ; 

entity font_test_gen is 
   port( 
       clk: in std_logic; 
       video_on: in std_logic;
       scoreHomeOut,scoreAwayOut : in std_logic_vector(11 downto 0);
       foulHomeOut,foulAwayOut,periodOut : in std_logic_vector(3 downto 0);
       pause,reset1: in std_logic; 
       pixel_x,pixel_y : in std_logic_vector (9 downto 0);                        
       rgb_text : out std_logic_vector (11 downto 0)  
     ); 
end font_test_gen; 
 
architecture arch of font_test_gen is

signal rom_addr1,rom_addr2,rom_addr3,rom_addr4,rom_addr5,rom_addr6,rom_addr7 : std_logic_vector (10 downto 0);
signal rom_addr8,rom_addr9,rom_addr10,rom_addr11,rom_addr12,rom_addr13,rom_addr14,rom_addr15 : std_logic_vector (10 downto 0);
signal rom_addr16,rom_addr17,rom_addr18,rom_addr19,rom_addr20,rom_addr21,rom_addr22,rom_addr23,rom_addr24 :std_logic_vector (10 downto 0);
signal char_addr1,char_addr2,char_addr3,char_addr4,char_addr5,char_addr6,char_addr7 : std_logic_vector (6 downto 0);
signal char_addr8,char_addr9,char_addr10,char_addr11,char_addr12,char_addr13,char_addr14 :std_logic_vector(6 downto 0);
signal char_addr15,char_addr16,char_addr17,char_addr18,char_addr19,char_addr20,char_addr21,char_addr22 :std_logic_vector(6 downto 0); 
signal row_addr1,row_addr2,row_addr3,row_addr4,row_addr5,row_addr6,row_addr7: std_logic_vector (3 downto 0);
signal row_addr8,row_addr9,row_addr10,row_addr11,row_addr12,row_addr13,row_addr14 : std_logic_vector(3 downto 0);
signal row_addr15,row_addr16,row_addr17,row_addr18,row_addr19,row_addr20,row_addr21,row_addr22 : std_logic_vector (3 downto 0);
signal bit_addr: std_logic_vector (2 downto 0);
signal font_word1,font_word2,font_word3,font_word4,font_word5,font_word6,font_word7: std_logic_vector (7 downto 0);
signal font_word8,font_word9,font_word10,font_word11,font_word12,font_word13,font_word14 :std_logic_vector(7 downto 0);
signal font_word15,font_word16,font_word17,font_word18,font_word19,font_word20,font_word21,font_word22 :std_logic_vector(7 downto 0);
signal font_bit1,font_bit2,font_bit3,font_bit4,font_bit5,font_bit6,font_bit7,text_bit_on : std_logic;
signal font_bit8,font_bit9,font_bit10,font_bit11,font_bit12,font_bit13,font_bit14 : std_logic;
signal font_bit20,font_bit21,font_bit15,font_bit16,font_bit17,font_bit18,font_bit19,font_bit22 : std_logic;
signal num: std_logic_vector (15 downto 0):=(others=> '0');
signal red : std_logic := '0';

signal bar_on : std_logic;
signal pix_x,pix_y : unsigned(9 downto 0);
constant MAX_X: integer :=640;
constant MAX_Y: integer :=480;

constant BAR_X_L: integer :=600;
constant BAR_X_R: integer :=603;
-- b a r t o p , b o t t o m b o u n d a r y
constant BAR_Y_SIZE: integer := 72;
constant BAR_Y_T : integer :=MAX_Y/2-BAR_Y_SIZE/2; --204
constant BAR_Y_B : integer :=BAR_Y_T+BAR_Y_SIZE-1;


component ClockNBtn
port(
       clk: in std_logic;
       pause,reset1: in std_logic;     
       num: out std_logic_vector (15 downto 0)  
);
end component;   

begin
-- instantiate font ROM 
font_unit: entity work.Asciiconve 
    port map(clk=>clk, addr=>rom_addr1 , dataOut=>font_word1); 
font_unit2: entity work.Asciiconve 
    port map(clk=>clk, addr=>rom_addr2 , dataOut=>font_word2); 
font_unit3: entity work.Asciiconve 
    port map(clk=>clk, addr=>rom_addr3 , dataOut=>font_word3);
font_unit4: entity work.Asciiconve 
    port map(clk=>clk, addr=>rom_addr4 , dataOut=>font_word4);
font_unit5: entity work.Asciiconve 
    port map(clk=>clk, addr=>rom_addr5 , dataOut=>font_word5);
font_unit6: entity work.Asciiconve 
    port map(clk=>clk, addr=>rom_addr6 , dataOut=>font_word6);
font_unit7: entity work.Asciiconve 
    port map(clk=>clk, addr=>rom_addr7 , dataOut=>font_word7);
font_unit8: entity work.Asciiconve 
    port map(clk=>clk, addr=>rom_addr8 , dataOut=>font_word8);
font_unit9: entity work.Asciiconve 
    port map(clk=>clk, addr=>rom_addr9 , dataOut=>font_word9);
font_unit10: entity work.Asciiconve 
    port map(clk=>clk, addr=>rom_addr10 , dataOut=>font_word10);
font_unit11: entity work.Asciiconve 
    port map(clk=>clk, addr=>rom_addr11 , dataOut=>font_word11);
font_unit12: entity work.Asciiconve 
    port map(clk=>clk, addr=>rom_addr12 , dataOut=>font_word12);
font_unit13: entity work.Asciiconve 
    port map(clk=>clk, addr=>rom_addr13 , dataOut=>font_word13);
font_unit14: entity work.Asciiconve 
    port map(clk=>clk, addr=>rom_addr14 , dataOut=>font_word14);
font_unit15: entity work.Asciiconve 
    port map(clk=>clk, addr=>rom_addr15 , dataOut=>font_word15);
font_unit16: entity work.Asciiconve 
    port map(clk=>clk, addr=>rom_addr16 , dataOut=>font_word16);
font_unit17: entity work.Asciiconve 
    port map(clk=>clk, addr=>rom_addr17 , dataOut=>font_word17);
font_unit18: entity work.Asciiconve 
    port map(clk=>clk, addr=>rom_addr18 , dataOut=>font_word18);
font_unit19: entity work.Asciiconve 
    port map(clk=>clk, addr=>rom_addr19 , dataOut=>font_word19);
font_unit20: entity work.Asciiconve 
    port map(clk=>clk, addr=>rom_addr20 , dataOut=>font_word20);
font_unit21: entity work.Asciiconve 
    port map(clk=>clk, addr=>rom_addr21 , dataOut=>font_word21);
font_unit22: entity work.Asciiconve 
    port map(clk=>clk, addr=>rom_addr22 , dataOut=>font_word22);
    
pix_x <= unsigned(pixel_x);
pix_y <= unsigned(pixel_y);    
    

-- b a r r g b o u t p u t


-- font ROM interface 
char_addr1 <= "000" & num(15 downto 12); -- 10th number of hours
row_addr1 <= pixel_y (5 downto 2); -- Row within the ROM
rom_addr1 <= char_addr1 & row_addr1; -- What is sent to the ROM

char_addr2 <= "000" & num(11 downto 8); -- First 10 hours of each day
row_addr2 <= pixel_y (5 downto 2); 
rom_addr2 <= char_addr2 & row_addr2; 

char_addr3 <= "0001010"; -- : between the hours and minutes
row_addr3 <= pixel_y (5 downto 2); 
rom_addr3 <= char_addr3 & row_addr3;
      
char_addr4 <=  "000" & num(7 downto 4); -- 10th number of minutes
row_addr4 <= pixel_y (5 downto 2); 
rom_addr4 <= char_addr4 & row_addr4;
             
char_addr5 <= "000" & num(3 downto 0); -- First 10 minutes of each hour
row_addr5 <= pixel_y (5 downto 2); 
rom_addr5 <= char_addr5 & row_addr5;

char_addr6 <= "000" & foulHomeOut; -- fouls left
row_addr6 <= pixel_y (4 downto 1); 
rom_addr6 <= char_addr6 & row_addr6;

char_addr7 <= "000" & foulAwayOut; -- fouls right
row_addr7 <= pixel_y (4 downto 1); 
rom_addr7 <= char_addr7 & row_addr7;

char_addr8 <= "000" & periodOut; -- period
row_addr8 <= pixel_y (4 downto 1); 
rom_addr8 <= char_addr8 & row_addr8;

char_addr9 <= "000" & scoreHomeOut(11 downto 8); -- home
row_addr9 <= pixel_y (4 downto 1); 
rom_addr9 <= char_addr9 & row_addr9;

char_addr10 <= "000" & scoreHomeOut(7 downto 4); -- home
row_addr10 <= pixel_y (4 downto 1); 
rom_addr10 <= char_addr10 & row_addr10;

char_addr11 <= "000" & scoreHomeOut(3 downto 0); -- home
row_addr11 <= pixel_y (4 downto 1); 
rom_addr11 <= char_addr11 & row_addr11;

char_addr12 <= "000" & scoreAwayOut(11 downto 8); -- away
row_addr12 <= pixel_y (4 downto 1); 
rom_addr12 <= char_addr12 & row_addr12;

char_addr13 <= "000" & scoreAwayOut(7 downto 4); -- away
row_addr13 <= pixel_y (4 downto 1); 
rom_addr13 <= char_addr13 & row_addr13;

char_addr14 <= "000" & scoreAwayOut(3 downto 0); -- away
row_addr14 <= pixel_y (4 downto 1); 
rom_addr14 <= char_addr14 & row_addr14;

char_addr15 <= "0001101"; -- H
row_addr15 <= pixel_y (4 downto 1); 
rom_addr15 <= char_addr15 & row_addr15;

char_addr16 <= "0001111"; -- O
row_addr16 <= pixel_y (4 downto 1); 
rom_addr16 <= char_addr16 & row_addr16;

char_addr17 <= "0001110"; -- M
row_addr17 <= pixel_y (4 downto 1); 
rom_addr17 <= char_addr17 & row_addr17;

char_addr18 <= "0001100"; -- E
row_addr18 <= pixel_y (4 downto 1); 
rom_addr18 <= char_addr18 & row_addr18;

char_addr19 <= "0001011"; -- A
row_addr19 <= pixel_y (4 downto 1); 
rom_addr19 <= char_addr19 & row_addr19;

char_addr20 <= "0010000"; -- W
row_addr20 <= pixel_y (4 downto 1); 
rom_addr20 <= char_addr20 & row_addr20;

char_addr21 <= "0001011"; -- A
row_addr21 <= pixel_y (4 downto 1); 
rom_addr21 <= char_addr21 & row_addr21;

char_addr22 <= "0010001"; -- Y
row_addr22 <= pixel_y (4 downto 1); 
rom_addr22 <= char_addr22 & row_addr22;

bit_addr <= pixel_x (3 downto 1); 
font_bit1 <= font_word1(to_integer(unsigned(not bit_addr)));
font_bit2 <= font_word2(to_integer(unsigned(not bit_addr)));
font_bit3 <= font_word3(to_integer(unsigned(not bit_addr)));
font_bit4 <= font_word4(to_integer(unsigned(not bit_addr)));
font_bit5 <= font_word5(to_integer(unsigned(not bit_addr)));
font_bit6 <= font_word6(to_integer(unsigned(not bit_addr)));
font_bit7 <= font_word7(to_integer(unsigned(not bit_addr)));
font_bit8 <= font_word8(to_integer(unsigned(not bit_addr)));
font_bit9 <= font_word9(to_integer(unsigned(not bit_addr)));
font_bit10 <= font_word10(to_integer(unsigned(not bit_addr)));
font_bit11 <= font_word11(to_integer(unsigned(not bit_addr)));
font_bit12 <= font_word12(to_integer(unsigned(not bit_addr)));
font_bit13 <= font_word13(to_integer(unsigned(not bit_addr)));
font_bit14 <= font_word14(to_integer(unsigned(not bit_addr)));
font_bit15 <= font_word15(to_integer(unsigned(not bit_addr)));
font_bit16 <= font_word16(to_integer(unsigned(not bit_addr)));
font_bit17 <= font_word17(to_integer(unsigned(not bit_addr)));
font_bit18 <= font_word18(to_integer(unsigned(not bit_addr)));
font_bit19 <= font_word19(to_integer(unsigned(not bit_addr)));
font_bit20 <= font_word20(to_integer(unsigned(not bit_addr)));
font_bit21 <= font_word21(to_integer(unsigned(not bit_addr)));
font_bit22 <= font_word22(to_integer(unsigned(not bit_addr)));

bar_on <= '1' when ((pix_x = 300) and --Left side
       (127 <= pix_y) and (pix_y <= 156)) or 
       ((300 <= pix_x) and (pix_x <= 321) and --Bottom side
       (pix_y = 156)) or
       ((pix_x = 321) and -- Right side
       (127 <= pix_y) and (pix_y <= 156)) or
       ((300 <= pix_x) and (pix_x <= 321) and -- Top side
       (pix_y = 127)) or
       
      --foul left
      ((28 = pix_x) and --Left side
      (384 <= pix_y) and (pix_y <= 411)) or 
      ((28 <= pix_x) and (pix_x <= 49) and --Bottom side
      (411 = pix_y)) or
      ((49 = pix_x) and -- Right side
      (384 <= pix_y) and (pix_y <= 411)) or
      ((28 <= pix_x) and (pix_x <= 49) and -- Top side
      (384 = pix_y)) or
     
      -- foul right
      ((588 = pix_x) and --Left side
      (384 <= pix_y) and (pix_y <= 411)) or 
      ((588 <= pix_x) and (pix_x <= 609) and --Bottom side
      (411 = pix_y)) or
      ((609 = pix_x) and -- Right side
      (384 <= pix_y) and (pix_y <= 411)) or
      ((588 <= pix_x) and (pix_x <= 609) and -- Top side
      (384 = pix_y)) or
      
      --Home + score
      ((124 = pix_x) and --Left side
      (95 <= pix_y) and (pix_y <= 158)) or 
      ((124 <= pix_x) and (pix_x <= 193) and --Bottom side
      (158 = pix_y)) or
      ((193 = pix_x) and -- Right side
      (95 <= pix_y) and (pix_y <= 158)) or
      ((124 <= pix_x) and (pix_x <= 193) and -- Top side
      (95 = pix_y)) or
      
      --Away + score
      ((428 = pix_x) and --Left side
      (95 <= pix_y) and (pix_y <= 158)) or 
      ((428 <= pix_x) and (pix_x <= 498) and --Bottom side
      (158 = pix_y)) or
      ((498 = pix_x) and -- Right side
      (95 <= pix_y) and (pix_y <= 158)) or
      ((428 <= pix_x) and (pix_x <= 498) and -- Top side
      (95 = pix_y)) or
      
      --clock
      ((268 = pix_x) and --Left side
      (256 <= pix_y) and (pix_y <= 312)) or 
      ((268 <= pix_x) and (pix_x <= 353) and --Bottom side
      (312 = pix_y)) or
      ((353 = pix_x) and -- Right side
      (256 <= pix_y) and (pix_y <= 312)) or
      ((268 <= pix_x) and (pix_x <= 353) and -- Top side
      (256 = pix_y)) or
      
      --Encapulation
      ((0 <= pix_x) and (pix_x <= 2) and --Left side
      (0 <= pix_y) and (pix_y <= 480)) or 
      ((0 <= pix_x) and (pix_x <= 640) and --Bottom side
      (478 <= pix_y) and (pix_y <= 480)) or
      ((638 <= pix_x) and (pix_x <= 640) and -- Right side
      (0 <= pix_y) and (pix_y <= 480)) or
      ((0 <= pix_x) and (pix_x <= 640) and -- Top side
      (0 <= pix_y) and (pix_y <= 2)) else
       '0'; 


-- "on" region limited to top_left corner, displays in the middle of the screen
process(clk,pixel_x,pixel_y,pix_x, pix_y,font_bit1,font_bit2,font_bit3,font_bit4,font_bit5,font_bit6,
font_bit7,font_bit8,font_bit9,font_bit10,font_bit11,font_bit12,font_bit13,font_bit14,font_bit15,font_bit16,
font_bit17,font_bit18,font_bit19,font_bit20,font_bit21,font_bit22,bar_on, foulHomeOut, foulAwayOut)
begin
    if  ((pixel_x (9 downto 4)= "010001" and 
        pixel_y (9 downto 5)="01001")) or ((pixel_x (9 downto 4)= "010001" and 
        pixel_y (9 downto 5)="01000")) then 
        text_bit_on <= font_bit1;
    
    elsif ((pixel_x (9 downto 4)= "010010" and 
        pixel_y (9 downto 5)="01001")) or ((pixel_x (9 downto 4)= "010010" and 
        pixel_y (9 downto 5)="01000"))then  
        text_bit_on <=font_bit2;
                                
    elsif ((pixel_x (9 downto 4)= "010011" and 
        pixel_y (9 downto 5)="01001")) or ((pixel_x (9 downto 4)= "010011" and 
        pixel_y (9 downto 5)="01000"))then 
        text_bit_on <=font_bit3;
          
    elsif ((pixel_x (9 downto 4)= "010100" and 
        pixel_y (9 downto 5)="01001")) or ((pixel_x (9 downto 4)= "010100" and 
        pixel_y (9 downto 5)="01000")) then 
        text_bit_on <=font_bit4; 
                                          
    elsif ((pixel_x (9 downto 4)= "010101" and 
        pixel_y (9 downto 5)="01001")) or ((pixel_x (9 downto 4)= "010101" and 
        pixel_y (9 downto 5)="01000"))then
        text_bit_on <=font_bit5;
     
    elsif (pixel_x (9 downto 4)= "000010" and --fouls left side
        pixel_y (9 downto 5)="01100") then
        text_bit_on <=font_bit6;    
        if foulHomeOut = "0101" then
            red <= '1';
        else
            red <= '0';
        end if;
        
    elsif (pixel_x (9 downto 4)= "100101" and --fouls right side
        pixel_y (9 downto 5)="01100") then
        text_bit_on <=font_bit7;  
        if foulAwayOut = "0101" then
            red <= '1';
        else
            red <= '0';
        end if;
        
    elsif (pixel_x (9 downto 4)= "010011" and --PERIOD --304 dec
        pixel_y (9 downto 5)="00100") then
        text_bit_on <=font_bit8;
       
    elsif (pixel_x (9 downto 4)= "001001" and --goals hometeam
        pixel_y (9 downto 5)="00100") then
        text_bit_on <=font_bit9; 
     
    elsif (pixel_x (9 downto 4)= "001010" and ---goals hometeam
        pixel_y (9 downto 5)="00100") then
        text_bit_on <=font_bit10;
   
    elsif (pixel_x (9 downto 4)= "001011" and --goals hometeam
        pixel_y (9 downto 5)="00100") then
        text_bit_on <=font_bit11;
    
    elsif (pixel_x (9 downto 4)= "011011" and --goals awayteam pix_x
        pixel_y (9 downto 5)="00100") then
        text_bit_on <=font_bit12;
     
    elsif (pixel_x (9 downto 4)= "011100" and --goals awayteam
        pixel_y (9 downto 5)="00100") then
        text_bit_on <=font_bit13; 
       
    elsif (pixel_x (9 downto 4)= "011101" and --goals awayteam
        pixel_y (9 downto 5)="00100") then
        text_bit_on <=font_bit14;
              
    elsif (pixel_x (9 downto 4)= "001000" and --H
        pixel_y (9 downto 5)="00011") then
        text_bit_on <=font_bit15;
        red <= '0';
     
    elsif (pixel_x (9 downto 4)= "001001" and --O
        pixel_y (9 downto 5)="00011") then
        text_bit_on <=font_bit16;
     
    elsif (pixel_x (9 downto 4)= "001010" and --M
        pixel_y (9 downto 5)="00011") then
        text_bit_on <=font_bit17;
    
    elsif (pixel_x (9 downto 4)= "001011" and --E
        pixel_y (9 downto 5)="00011") then
        text_bit_on <=font_bit18;
     
    elsif (pixel_x (9 downto 4)= "011011" and --A
        pixel_y (9 downto 5)="00011") then
        text_bit_on <=font_bit19;
      
    elsif (pixel_x (9 downto 4)= "011100" and --W
        pixel_y (9 downto 5)="00011") then
        text_bit_on <=font_bit20;
      
    elsif (pixel_x (9 downto 4)= "011101" and --A
        pixel_y (9 downto 5)="00011") then
        text_bit_on <=font_bit21;
        
    elsif (pixel_x (9 downto 4)= "011110" and --Y
        pixel_y (9 downto 5)="00011") then
        text_bit_on <=font_bit22;
       
     --period                                                        
    else 
      text_bit_on <= '0';        
    end if;
end process;

--rgb multiplexing circuprocess(video_on,font_bit,text_bit_on)
process(video_on,text_bit_on,font_bit1,font_bit2,font_bit3,font_bit4,font_bit5,red,bar_on)
begin
 if video_on='0' then 
    rgb_text <= "000000000000"; --blank
 else 
    if text_bit_on='1' then
        if red = '1' then
            rgb_text <= "000000001111";
        else
            rgb_text <= "000011111111"; --green + blue
        end if;
    elsif bar_on = '1' then
        rgb_text <= "000011111111";
    else
        rgb_text <= "000000000000"; --black
    end if;
 end if;

end process;

clkclock: ClockNBtn 
port map(
    clk => clk,
    pause => pause,
    reset1 => reset1,
--   btnC_de => btnC_de, --reset
  -- btnU_de => btnU_de,
   --btnR_de => btnR_de,
   --btnD_de => btnD_de,
   --o_sw => o_sw,
   num => num   
);

end arch; 