library ieee;
use ieee.std_logic_1164.all ;
use ieee. numeric_std.all ;

entity font_test_top is 
Generic( clk_freq         : INTEGER := 100_000_000; --system clock frequency in Hz
         ps2_counter_size : INTEGER := 9); 
port(
     clk : in std_logic;
     sw: in std_logic_vector(0 downto 0); 
     Hsync, Vsync: out std_logic;
     PS2Clk      : IN  STD_LOGIC;                     --clock signal from PS/2 keyboard
     PS2Data     : IN  STD_LOGIC; 
     rgb: out std_logic_vector (11 downto 0) 
 );
end font_test_top; 
 
architecture arch of font_test_top is 
signal pixel_x , pixel_y : std_logic_vector (9 downto 0); 
signal video_on , pixel_tick: std_logic; 
signal rgb_reg , rgb_next : std_logic_vector (11 downto 0);
signal ps2_code :std_logic_vector(7 downto 0);
signal ps2_clk      :   STD_LOGIC;                     --clock signal from PS/2 keyboard
signal ps2_data, ps2_code_new     : STD_LOGIC; 
SIGNAL ps2_two_code :std_logic_vector(7 downto 0):= (others=> '0');
signal scoreHomeOut,scoreAwayOut :std_logic_vector (11 downto 0);
signal foulHomeOut,foulAwayOut, periodOut :std_logic_vector(3 downto 0);
signal pause,reset1,reset: std_logic;

component SpecifyKeys
 GENERIC(
     clk_freq              : INTEGER;          --system clock frequency in Hz
     debounce_counter_size : INTEGER);   
port(
       clk: in std_logic;      
       PS2Clk      : IN  STD_LOGIC;                     --clock signal from PS/2 keyboard
       PS2Data     : IN  STD_LOGIC;                     --data signal from PS/2 keyboard
       scoreHomeOut,scoreAwayOut : out std_logic_vector(11 downto 0);
       foulHomeOut,foulAwayOut, periodOut : out std_logic_vector(3 downto 0);
       pause,reset1: out std_logic                      
       );
end component;

component font_test_gen
port(
        clk: in std_logic; 
        video_on: in std_logic;
        pixel_x , pixel_y : in std_logic_vector (9 downto 0);
        scoreHomeOut,scoreAwayOut : in std_logic_vector(11 downto 0);
        foulHomeOut,foulAwayOut, periodOut : in std_logic_vector(3 downto 0);
        pause,reset1: in std_logic;
        rgb_text : out std_logic_vector (11 downto 0)   
);
end component;  

begin -- instantiate VGA sync circuit 

Keys: SpecifyKeys 
generic map(
    clk_freq => clk_freq,
    debounce_counter_size => ps2_counter_size)
port map(
    clk=>clk,
    PS2Clk=>PS2Clk,
    PS2Data=>PS2Data,
    scoreHomeOut=>scoreHomeOut,
    scoreAwayOut=>scoreAwayOut,
    foulHomeOut=>foulHomeOut,
    foulAwayOut=>foulAwayOut,
    periodOut=>periodOut,
    pause=>pause,
    reset1=>reset1
);

--Timing and pixel_y/x generator
vga_sync_unit : entity work.vga_sync 
    port map
    (clk=>clk , reset=>reset ,
    hsync=>hsync , 
    vsync=>vsync, 
    video_on=>video_on, 
    pixel_x=>pixel_x, 
    pixel_y=>pixel_y, 
    p_tick=>pixel_tick);

--instantiate font ROM 
font_gen_unit: font_test_gen 
    port map( clk => clk , 
    video_on => video_on,
    scoreHomeOut => scoreHomeOut, 
    scoreAwayOut => scoreAwayOut,
    foulHomeOut => foulHomeOut,
    foulAwayOut => foulAwayOut,
    periodOut => periodOut,
    pixel_x => pixel_x, 
    pixel_y => pixel_y,
    pause => pause,
    reset1 => reset1,
    rgb_text => rgb_next
    ); 

reset <= sw(0);-- reset switch for sync and debounce

-- rgb buffer 
process (clk) 
    begin 
        if (clk'event and clk='1') then 
            if (pixel_tick='1') then
                rgb_reg <= rgb_next ; 
            end if ; 
        end if ; 
end process; 
    rgb <= rgb_reg; --output logic 
end arch; 
