----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/26/2023 01:59:00 PM
-- Design Name: 
-- Module Name: arithmetic_system - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity arithmetic_system is
    port(
        clk : in std_logic;
        a, b : in std_logic_vector (3 downto 0);
        sel : in std_logic_vector (1 downto 0);
        cathodes : out std_logic_vector (6 downto 0);
        anodes : out std_logic_vector (3 downto 0)
    );
end arithmetic_system;

architecture Behavioral of arithmetic_system is
    signal comp : std_logic_vector (2 downto 0);
    signal a0, a1, b0, b1, r0, r1: std_logic_vector (3 downto 0);
    signal sum_a, sum_b, sum0, sum1: std_logic_vector (4 downto 0);
    signal a1a0, b1b0 : std_logic_vector (7 downto 0);
    signal sub : std_logic_vector (8 downto 0);
    signal display0, display1, display2, dr0, dr1, dcom: std_logic_vector (6 downto 0);
begin
U0: entity work.bcd_adder port map(a => a, b => "0000", c_in => '0', s => sum_a);
U1: entity work.bcd_adder port map(a => b, b => "0000", c_in => '0', s => sum_b);
    a0 <= sum_a(3 downto 0);
    a1 <= "000" & sum_a(4);
    b0 <= sum_b(3 downto 0);
    b1 <= "000" & sum_b(4);
U2: entity work.bcd_adder port map(a => a0, b => b0, c_in => '0', s => sum0);
U3: entity work.bcd_adder port map(a => a1, b => b1, c_in => sum0(4), s => sum1);
    a1a0 <= a1 & a0;
    b1b0 <= b1 & b0;
U4: entity work.bcd_subtractor port map(a => a1a0, b => b1b0, s => sub);
U5: entity work.comparator port map(a => a, b => b, l => comp(2), e => comp(1), g => comp(0));
    r0 <= sum0(3 downto 0) when sel(0) = '0' else sub(3 downto 0);
    r1 <= sum1(3 downto 0) when sel(0) = '0' else sub(7 downto 4);
U6: entity work.bcd_to_7seg port map(bcd => r0, segments => dr0);
U7: entity work.bcd_to_7seg port map(bcd => r1, segments => dr1);
U8: entity work.comp_to_7seg port map(m => comp, segments => dcom);
    with sel select
        display0 <= dr0 when "00",
                    dr0 when "01",
                    dcom when "10",
                    "1111111" when others;
    with sel select
        display1 <= dr1 when "00",
                    dr1 when "01",
                    "1111111" when others;
    with sel select
        display2 <= not(sum1(4)) & "111111" when "00",
                    not(sub(8)) & "111111" when "01",
                    "1111111" when others;
U9: entity work.display_7seg_multiplexer port map(clk100M => clk, display0 => display0, display1 => display1,
    display2 => display2, anodes => anodes, cathodes => cathodes);
end Behavioral;
