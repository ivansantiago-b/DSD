----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/06/2023 11:12:16 AM
-- Design Name: 
-- Module Name: divider_data_path - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity divider_data_path is
    port(
        clock, reset, d_we, d_sel, d_en, i_we, y_we, result_we, b_we : in std_logic;
        x, y : in std_logic_vector(15 downto 0);
        flags : out std_logic_vector(2 downto 0);
        d, m : out std_logic_vector(15 downto 0)
    );
end divider_data_path;

architecture Behavioral of divider_data_path is
    signal i_in, i : std_logic_vector(4 downto 0);
    signal sh_in, sh : std_logic_vector(31 downto 0);
    signal borrow : std_logic;
    signal sub: std_logic_vector(16 downto 0);
    signal ry : std_logic_vector(15 downto 0);
begin
I_REGISTER:
    entity work.reg generic map(n => 5) port map(clock => clock, reset => reset, we => i_we, data_in => i_in, data_out => i);
    i_in <= std_logic_vector(unsigned(i) + 1);
Y_REGISTER:
    entity work.reg generic map(n => 16) port map(clock => clock, reset => reset, we => y_we, data_in => y, data_out => ry);
DIV_REGISTER:
    entity work.reg generic map(n => 16) port map(clock => clock, reset => reset, we => result_we, data_in => sh(15 downto 0), data_out => d);
MOD_REGISTER:
    entity work.reg generic map(n => 16) port map(clock => clock, reset => reset, we => result_we, data_in => sh(31 downto 16), data_out => m);
SHIFT_REGISTER:
    entity work.shift_reg generic map(n => 32) port map(clock => clock, reset => reset, we => d_we, en => d_en, r_in => borrow, r_we => b_we, data_in => sh_in, data_out => sh);
    sh_in(31 downto 16) <= (others => '0') when d_sel = '1' else sub(15 downto 0);
    sh_in(15 downto 0) <= x when d_sel = '1' else sh(15 downto 0);
    sub <= std_logic_vector(unsigned('0' & sh(31 downto 16)) - unsigned('0' & ry));
    borrow <= not(sub(16));
    flags(0) <= '1' when unsigned(i) = 17 else '0';
    flags(1) <= borrow;
    flags(2) <= '1' when unsigned(ry) > 0 else '1';
end Behavioral;
