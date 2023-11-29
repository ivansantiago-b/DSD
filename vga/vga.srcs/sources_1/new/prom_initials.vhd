----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/28/2023 10:31:43 PM
-- Design Name: 
-- Module Name: prom_initials - Behavioral
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

entity prom_initials is
    port(
        address : in std_logic_vector(3 downto 0);
        row : out std_logic_vector(0 to 30)
    );
end prom_initials;

architecture Behavioral of prom_initials is
    type rom_array is array (NATURAL range<>) of std_logic_vector(0 to 30);
    constant rom : rom_array := (
        "1111111111111111111111111111111",
        "1000000000000000000000000000001",
        "1011111111111111111111111111101",
        "1010000000000000000000000000101",
        "1010111110111110011100111100101",
        "1010000100001000100010100010101",
        "1010000100001000100000100010101",
        "1010000100001000011100111100101",
        "1010000100001000000010100010101",
        "1010100100001000100010100010101",
        "1010011000111110011100111100101",
        "1010000000000000000000000000101",
        "1011111111111111111111111111101",
        "1000000000000000000000000000001",
        "1111111111111111111111111111111",
        "0000000000000000000000000000000"
    );
begin
    process(address)
        variable a : integer;
    begin
        a := to_integer(unsigned(address));
        row <= rom(a);
    end process;
end Behavioral;
