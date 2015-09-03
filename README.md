## df_node_fix - A bunch of silly processes to attemt to get node to not require sudo to run npm

Why not run node as sudo? Because it creates a bunch of problems downstream with tools such as yeoman

This cookbook was created by someone who doesn't know what he is doing (I'm a dev, not an ops guy) so use it at your own risk, preferably after reading the default.rb recipe.

Most of this was taken from hours of googling, and then attempting to run what I learned as a Chef recipe.

## Danger - /usr/local is owned by vagrant:vagrant, not root! 

