--+----------------------------------------------------------------------------
--| 
--| COPYRIGHT 2018 United States Air Force Academy All rights reserved.
--| 
--| United States Air Force Academy     __  _______ ___    _________ 
--| Dept of Electrical &               / / / / ___//   |  / ____/   |
--| Computer Engineering              / / / /\__ \/ /| | / /_  / /| |
--| 2354 Fairchild Drive Ste 2F6     / /_/ /___/ / ___ |/ __/ / ___ |
--| USAF Academy, CO 80840           \____//____/_/  |_/_/   /_/  |_|
--| 
--| ---------------------------------------------------------------------------
--|
--| FILENAME      : sevenSegDecoder.vhd
--| AUTHOR(S)     : C3C Emile Olivier
--| CREATED       : 02/25/2024
--| DESCRIPTION   : This file implements the seven segment decoder, taking a 
--|                 4-bit input and converting it to a 7-bit output to cause
--|                 a 7-seg display to display the hexadecimal value.  
--|					
--|                 Input:  i_D(3:0)   --> a 4-bit input for the value to display
--|                 Output: o_S(6:0)   --> a 7-bit output decribing the segments to light up
--+----------------------------------------------------------------------------
--|
--| REQUIRED FILES :
--|
--|    Libraries : ieee
--|    Packages  : std_logic_1164, numeric_std
--|    Files     : None
--|
--+----------------------------------------------------------------------------
--|
--| NAMING CONVENSIONS :
--|
--|    xb_<port name>           = off-chip bidirectional port ( _pads file )
--|    xi_<port name>           = off-chip input port         ( _pads file )
--|    xo_<port name>           = off-chip output port        ( _pads file )
--|    b_<port name>            = on-chip bidirectional port
--|    i_<port name>            = on-chip input port
--|    o_<port name>            = on-chip output port
--|    c_<signal name>          = combinatorial signal
--|    f_<signal name>          = synchronous signal
--|    ff_<signal name>         = pipeline stage (ff_, fff_, etc.)
--|    <signal name>_n          = active low signal
--|    w_<signal name>          = top level wiring signal
--|    g_<generic name>         = generic
--|    k_<constant name>        = constant
--|    v_<variable name>        = variable
--|    sm_<state machine type>  = state machine type definition
--|    s_<signal name>          = state name
--|
--+----------------------------------------------------------------------------


library IEEE;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity sevenSegDecoder is
    Port ( 
        i_D : in STD_LOGIC_VECTOR (3 downto 0);
        o_S : out STD_LOGIC_VECTOR (6 downto 0)
    );
end sevenSegDecoder;

architecture sevenSegDecoder_arch of sevenSegDecoder is
    --components and signals
    signal c_Sa : std_logic := '1';
    signal c_Sb : std_logic := '1';
    signal c_Sc : std_logic := '1';
    signal c_Sd : std_logic := '1';
    signal c_Se : std_logic := '1';
    signal c_Sf : std_logic := '1';
    signal c_Sg : std_logic := '1';
    
begin
    -- port maps for component instantiations (not used)
    -- concurrent signal assignments
    c_Sa <= (i_D(2) and not i_D(1) and not i_D(0)) or 
            (i_D(3) and i_D(2) and not i_D(1)) or 
            (i_D(3) and not i_D(2) and i_D(1) and i_D(0)) or 
            (not i_D(3) and not i_D(2) and not i_D(1) and i_D(0));
    o_S(0) <= c_Sa;
    
    c_Sb <= (i_D(2) and i_D(1) and not i_D(0)) or
            (i_D(3) and i_D(1) and i_D(0)) or
            (not i_D(3) and i_D(2) and not i_D(1) and i_D(0)) or
            (i_D(3) and i_D(2) and not i_D(1) and not i_D(0));
    o_S(1) <= c_Sb;
    
    c_Sc <= '1' when    ((i_D = x"2") or
                         (i_D = x"c") or
                         (i_D = x"e") or
                         (i_D = x"f")
                        ) else '0';
    o_S(2) <= c_Sc;
    
    c_Sd <= '1' when    ((i_D = x"1") or
                         (i_D = x"4") or 
                         (i_D = x"7") or 
                         (i_D = x"9") or
                         (i_D = x"a") or
                         (i_D = x"f")
                        ) else '0';
    o_S(3) <= c_Sd;
    
    c_Se <= '1' when    ((i_D = x"1") or
                         (i_D = x"3") or
                         (i_D = x"4") or 
                         (i_D = x"5") or
                         (i_D = x"7") or
                         (i_D = x"9")
                        ) else '0';
    o_S(4) <= c_Se;
    
    c_Sf <= '1' when    ((i_D = x"1") or 
                         (i_D = x"2") or
                         (i_D = x"3") or
                         (i_D = x"7") or
                         (i_D = x"c") or
                         (i_D = x"d")
                        ) else '0';
    o_S(5) <= c_Sf;
    
    c_Sg <= '1' when    ((i_D = x"0") or
                         (i_D = x"1") or
                         (i_D = x"7")
                        ) else '0';
    o_S(6) <= c_Sg;

end sevenSegDecoder_arch;
