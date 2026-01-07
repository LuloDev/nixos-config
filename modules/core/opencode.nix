{ pkgs, llm-agents, ... }:
{
  environment.systemPackages = with llm-agents.packages.${pkgs.system}; [
    opencode
  ];
}
