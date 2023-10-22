----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/22/2023 12:10:36 AM
-- Design Name: 
-- Module Name: dabble - Behavioral
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

entity dabble is
    port(
        input : in std_logic_vector(3 downto 0);
        output : out std_logic_vector(3 downto 0)
    );
end dabble;

architecture Behavioral of dabble is

begin
    with input select
        output <= "0000" when "0000",
                  "0001" when "0001",
                  "0010" when "0010",
                  "0011" when "0011",
                  "0100" when "0100",
                  "1000" when "0101",
                  "1001" when "0110",
                  "1010" when "0111",
                  "1011" when "1000",
                  "1100" when "1001",
                  "1111" when others;
end Behavioral;
