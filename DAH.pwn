//==========================================================//
#include            <a_samp>
#include            <zcmd>
#include            <discord-connector>
#include            <discord-cmd>
#include            <sscanf2>
//================ put here ur chat id's ==================//
#define             d_chatlog           "730270219905400837" 
#define             d_chatreports       "731543345570119680"
#define             d_chatquestions     "731543411320160439"
//=========================================================//
new playername[MAX_PLAYER_NAME];
new idname[MAX_PLAYER_NAME];

static DCC_Channel:chatlog;
static DCC_Channel:chatreports;
static DCC_Channel:chatquestions;
//=========================================================//
public OnFilterScriptInit()
{
    printf("initializing discord admin helper for sa-mp\nif u have any questions, contact me on discord: gaps#7241");
    chatlog = DCC_FindChannelById(d_chatlog);
    chatreports = DCC_FindChannelById(d_chatreports);
    chatquestions = DCC_FindChannelById(d_chatquestions);
	return 1;
}
public OnPlayerConnect(playerid)
{
    new string[128];
    GetPlayerName(playerid, playername, sizeof(playername));
    SendClientMessage(playerid, -1, "Welcome %s :)\nthis server uses the admin helper discord made by gaps\nvisit: github.com/heygaps");
    format(string, sizeof(string), "%s joined into server", playername);
    DCC_SendChannelMessage(chatlog, string);
    return 1;
}
CMD:question(playerid, params[])
{
    new string[128], text[128];
    GetPlayerName(playerid, playername, sizeof(playername));
    if(sscanf(params, "s[128]", text)) return SendClientMessage(playerid, -1, "ERROR: you need to type a question");
    format(string, sizeof(string), "[IN-GAME] player %s [ID:%d] sended a question: %s (to reply use !reply [id] [text])", playername, playerid, text);
    SendClientMessage(playerid, -1, "Your question was sent to all administrators out-game, please wait.");
    DCC_SendChannelMessage(chatquestions, string);
    return 1;
}
DDCMD:reply(DCC_Channel:channel, DCC_User:AdminName, playerid, params[])
{
    new string[256], id, text[512];
    format(string, sizeof(string), "[ADMIN-REPLY] %s replied your question: %s", GetNickDiscord(AdminName), text);
    SendClientMessage(id, -1, string);
    return 0;
}
CMD:report(playerid, params[])
{
    new string[128], id, reason[128];
    GetPlayerName(playerid, playername, sizeof(playername)), GetPlayerName(id, idname, sizeof(idname));
    if(sscanf(params, "us[128]", id, reason)) return SendClientMessage(playerid, -1, "ERROR: you need to type a valid reason/player id");
    format(string, sizeof(string), "[IN-GAME] %s [ID:%d] reported %s [ID:%d], reason: %s", playername, playerid, idname, id, reason);
    SendClientMessage(playerid, -1, "You report was sent to all administrators out-game, please wait.")
    DCC_SendChannelMessage(chatreports, string);
    return 1;
}
