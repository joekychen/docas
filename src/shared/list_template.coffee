

# ### Micro Template Engine for Rendering Content
template = (str) ->
  new Function 'obj',
    'var p=[],print=function(){p.push.apply(p,arguments);};' +
    'with(obj){p.push(\'' +
    str.replace(/[\r\t\n]/g, " ")
       .replace(/'(?=[^<]*%>)/g,"\t")
       .split("'").join("\\'")
       .split("\t").join("'")
       .replace(/<%=(.+?)%>/g, "',$1,'")
       .split('<%').join("');")
       .split('%>').join("p.push('") +
       "');}return p.join('');"


# ### Template for File Browser
list_template = template """
<div depth="<%= index_path.length %>" class="filelist">
<table class="repo_nav">
<thead><tr><th></th><th>name</th><th class="<%= size %>"><span>sloc</span>&nbsp;&nbsp;<span>size</span></th><th>age</th><th class="<%= message %>"><span>message</span>&nbsp;&nbsp;<span>description</span><div class="history"><a target="_blank" href="https://github.com/<%= user %>/<%= repo %>/commits/master">history</a></div></th></tr></thead>
<tbody>
<% if(index_path.length) { %>
<tr class="directory"><td></td><td><a backward>..</a></td><td></td><td></td><td></td></tr>
<% } %>
<% entries.forEach(function(entry) { %>
<tr class="<%= entry.type %><%= entry.is_markdown ? ' markdown' : '' %><%= entry.name.toLowerCase() == 'readme.md' ? ' shown' : '' %>">
<td class="icon"></td>
<td><a <%= entry.type == 'd' ? 'forward' : entry.is_markdown ? 'markdown=\"' + entry.document + '\"' : 'href=\"' + (entry.type == 'm' ? 'https://github.com/' + entry.submodule : (entry.action === 's' ? index_path.concat(entry.document).join('/') : 'https://github.com/' + user + '/' + repo + '/blob/master/' + index_path.concat(entry.name).join('/'))) + '\"' %><%= entry.action === "g" ? "target=\'_blank\'": "" %>><%= entry.name %></a></td>
<td class="<%= size %>"><span><%= entry.sloc ? (entry.sloc + " " + (entry.sloc > 1 ? "lines" : "line")) : "-" %></span><span><%= entry.size %></span></td>
<td <%= (typeof entry.modified) === 'string' ? '' : 'relative_date="' + entry.modified * 1000 + '"' %>><%= (typeof entry.modified) === 'string' ? entry.modified : '' %></td>
<td class="<%= message %>"><div><span><%= entry.message %></span><span class="file_browser_author" email="<%= entry.email %>"> <%= entry.author %></span></div><div><%= entry.description %></div></td>
</tr>
<% }); %>
</tbody>
</table>
<div class="spinner"></div>
</div>
""".replace '\n', ''

if typeof window is 'undefined'
  module.exports = list_template
