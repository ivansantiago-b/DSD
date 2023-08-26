----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/26/2023 02:10:50 PM
-- Design Name: 
-- Module Name: bcd_adder - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity bcd_adder is
    port(
        a, b : in std_logic_vector (3 downto 0);
        c_in : in std_logic;
        s : out std_logic_vector (4 downto 0)
    );
end bcd_adder;

architecture Behavioral of bcd_adder is
    signal sum : std_logic_vector (4 downto 0);
begin
    sum <= ('0' & a) + ('0' & b) + ("0000" & c_in);
    s <= sum when sum < 10 else sum + 6;
end Behavioral;