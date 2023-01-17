#!/usr/bin/python2
# -*- coding:utf-8 -*-


""" 
*****************************************************************
脚本说明：
目录：需要放在pod工程的根目录下，即和 .podspec 文件同一目录
执行脚本可选参数有
--auto          : 自增版本号，只增加最后一位(只有自增版本号时，才会自动打tag，否则手动打tag)
--auto-remove   : 删除当前tag并重新打tag，不修改podspec的版本号
--use-libraries : 使用 --use-libraries
--verbose       : 使用 ---verbose       (发布时将显示所有log)
--allow-warnings: 使用 --allow-warnings (是否忽略警告，大多数都需要此参数)
--push          : 表示直接上传到pod       (默认为 验证 ，即 pod lib lint)
repo=           : 本地私有化仓库名称，准备做私有库发布的
--m : 版本commit信息,多行用;隔开，=, 会把commit信息，写入readMe 中

完整示例:
1. 自增版本号，只增加最后一位（1.0.0 ---> 1.0.1）
python ZWAuto_pod.py --auto --push --repo=sunny-specs --m="1.这次更新了****;2.这次还更新了****"

2. 推送至代码仓库失败时，删除当前组件远程git仓库tag，并重新打tag，不修改podspec的版本号
python ZWAuto_pod.py --auto-remove --push --repo=sunny-specs  --m="1.这次更新了****;2.这次还更新了****"

3. 自定义tag版本号（指定版本号1.0.0）
python ZWAuto_pod.py --push --repo=sunny-specs --tagVersion=0.1.1 --m="1.这次更新了****;2.这次还更新了****"
*****************************************************************
"""
#pod repo push sunny-specs ZWToolKit.podspec --verbose
#  --sources="https://github.com/sunnyzw/sunny-specs, https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git"
# --allow-warnings --skip-import-validation

import os, sys
import fileinput
import time

# print('\n')
# print('=================== 参数 ==================')
# print('argvs = %s'%sys.argv)
# print('===========================================')
# print('\n\n')

# mygit = ''
# sources = ['https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git']


# 是否需要拉取git远端代码，有其他人提交代码后需要先拉取远端代码到本地
is_gitPull = False

# 是否需要执行pod update，如果新版本需要依赖下层组件的变更，那需要执行pod update，
# 拉取最新的下层组件到本地，否则执行xcode build时会校验不通过
is_podUpdate = False

# 是否是正式发布， False 为验证
is_release_push = False

# 是否自动修改tag 和 .podspec的 version
auto_tag = ''

# podspec 和 git tag 的版本号
tag_version = ''

# 用于接收 --use-libraries 参数
use_libraries = '--use-libraries'

# 用于接收 --verbose 参数
verbose = '--verbose'

# 用于接收 --allow-warnings 参数 
allow_warnings = '--allow-warnings'

# .podspec 的名称
spec_name = ''

# 本地 repo 的名称
repo_name = ''

#readMe的修改信息 用于接收--m 参数
readme_commit = ''

sources = [
    #私有库源
    'https://github.com/sunnyzw/sunny-specs',
    #清华源
    'https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git'
]
# 用于接收 --sources 参数
sourcesStr = ''

# 获取参数
def get_args():

    global auto_tag
    global use_libraries
    global verbose
    global allow_warnings
    global repo_name
    global is_release_push
    global tag_version

    global sources
    global sourcesStr
    global is_gitPull

    global readme_commit

    for arg in sys.argv:
        if arg == '--auto' or arg == '--auto-remove':
            auto_tag = arg
        elif arg == '--use-libraries':
            use_libraries = '{}{}'.format(' ', arg)
        elif arg == '--verbose':
            verbose = ' %s' % (arg)
        elif arg == '--allow-warnings':
            allow_warnings = ' ' + arg
        elif arg.startswith('--sources='):
            sourcesStr = ' ' + arg    
        elif arg.startswith('--repo='):
            liarg = arg.split('=', 1)
            repo_name = liarg[1]
        elif arg == '--push':
            is_release_push = True
        elif arg == '--gitpull':
            is_gitPull = True
        elif arg == '--retag':
            is_release_push = True
        elif arg.startswith('--tagVersion='):
            artag = arg.split('=', 1)
            tag_version = artag[1]
        elif arg.startswith('--m='):
            arCommit = arg.split('=', 1)
            readme_commit = arCommit[1]

    print('\n======== 解析参数，赋值给全局变量 ==========')
    if auto_tag == '--auto':
        print('=== auto_tag     : %s (自动增加版本号)' % auto_tag)
    elif auto_tag == '--auto-remove':
        print('=== auto_tag     : %s (删除当前tag并重新打tag)' % auto_tag)
    else:
      if tag_version =='':
        print('=== 指定版本号     : 指定版本号和 git tag %s'%tag_version)
      else:
        print('=== auto_tag     : 不处理版本号和 git tag')
    
    
    print('=== use_libraries    : %s' % use_libraries)
    print('=== verbose          : %s' % verbose)
    print('=== allow_warnings   : %s' % allow_warnings)
    print('=== repo_name        : %s' % repo_name)
    print('============================================\n')

def get_gitRepoRemoteCode():
    os.system('git pull')


# ============================
# 获取spec路径
# ============================
def get_spec_filepath():

    global spec_name
    # 获取 podspec文件路径和文件名
    work_path = os.getcwd()
    list_file = os.path.split(work_path)
    spec_name = list_file[-1]+'.podspec'
    spec_full_path = work_path + '/' + spec_name

    return (spec_full_path)

def get_specName():

    global spec_name
    # 获取 podspec文件路径和文件名
    work_path = os.getcwd()
    for fileName in os.listdir(work_path):
      if fileName.endswith('.podspec'):
       spec_name = fileName

    return spec_name

def get_readme_filepath():

    global spec_name
    # 获取 podspec文件路径和文件名
    work_path = os.getcwd()
    # list_file = os.path.split(work_path)
    # spec_full_path = os.path.dirname(list_file[0]) + '/' + 'README.md'
    spec_full_path = work_path + '/' + 'README.md'
    return (spec_full_path)

    
# ============================
# 修改 spec 的 version，
# 并同步给tag_version
# ============================
def edit_spec_version():
    fileName = get_specName()
    print('========== 当前文件夹下的specName ==========')
    print(fileName)
    print('============================================\n')

    filepath = os.getcwd() + '/' + spec_name
    print('================ spec 路径 =================')
    print(filepath)
    print('============================================\n')

    global auto_tag
    global tag_version

    file = open(filepath, 'r+')
    all_line = file.readlines()

    for i,line in enumerate(all_line):

        if line.find('s.version') != -1:

            # 获取整个版本号，并trip掉空格和单引号
            version_full = line.split('=')[1]
            trip_version = version_full.replace(' ', '')
            trip_version = trip_version.replace('\'', '')

            if auto_tag == '--auto':
                # 获取版本号的最后一位
                versionWrap = trip_version.split('.')
                version_last_value = versionWrap[-1]

                # 获取 +1 后的版本号
                new_last_version = int(version_last_value) + 1
                versionWrap[-1] = str(new_last_version)

                # 得到最新版本号，并赋给 tag_version
                new_version = str.join('.',versionWrap)
                tag_version = new_version

                # 修改当前行的版本内容，为写入做准备，需要有回车
                # 样例 line = s.version = '0.1.8' + 回车
                write_version = ' \'%s\'\n'%(new_version)
                line = line.replace(version_full, write_version)
                all_line[i] = line
           
            elif auto_tag == '--auto-remove':
                tag_version = trip_version
            else:
                # 修改当前行的版本内容，为写入做准备，需要有回车
                # 样例 line = s.version = '0.1.8' + 回车
                write_version = ' \'%s\'\n'%(tag_version)
                line = line.replace(version_full, write_version)
                all_line[i] = line

            break

    file.close()

    with open(filepath ,'w') as wfile:
        wfile.writelines(all_line)
        wfile.close()
        
def edit_readme():
    if readme_commit != '':
      readmepath = get_readme_filepath()
      file = open(readmepath, 'a')
      commitcontent ='\n '+'Tag: ' + tag_version +'\n'+ readme_commit.replace(';','\n')
      file.write(commitcontent)
      file.close()    

def commit_and_push_git():

    global tag_version
    global auto_tag

    # commit 命令
    ctime = time.strftime("%Y-%m-%d %H:%M%:%S",time.localtime())
    commit_command = 'git commit -m "AUTO_VERSION   最新上传日期：%s       版本号：%s"' % (ctime,tag_version)

    # 获取当前分支名称, push命令
    git_head = os.popen('git symbolic-ref --short -q HEAD')
    current_branch = git_head.read()
    git_head.close()
    push_command = 'git push origin %s'%(current_branch)

    if auto_tag == '--auto-remove':
        remove_localtag_command = 'git tag -d %s'%(tag_version)
        remove_tag_command = 'git push origin :refs/tags/%s' % (tag_version)
        print('\n')
        print('---------------- git tag -d ----------------')
        os.system(remove_localtag_command)
        os.system(remove_tag_command)

    # tag 命令
    git_tag_command_local = 'git tag -m "%s %s" %s'%('version :',tag_version,tag_version)
    #git_tag_command_remote = 'git push --tag'
    git_tag_command_remote = 'git push origin %s' % (tag_version)
    # 调用 git 命令
    os.system('git add .')

    commit_open = os.popen(commit_command)
    commit_rsp = commit_open.read()
    commit_open.close()
    print('\n---------------- git commit ----------------')
    print(commit_rsp)

    print('\n----------------- git push -----------------')
    push_open = os.popen(push_command)
    push_rsp = push_open.read()
    push_open.close()


    print('\n------------------ git tag -----------------')
    local_tag_open = os.popen(git_tag_command_local)
    local_tag_rsp = local_tag_open.read()
    local_tag_open.close()

    remote_tag_open = os.popen(git_tag_command_remote)
    remote_tag_rsp = remote_tag_open.read()
    remote_tag_open.close()


# pod 验证
def pod_spc_lint():
    pod_lint_command = 'pod spec lint %s%s%s%s' % (
        spec_name, allow_warnings, use_libraries, verbose)
    print('\n======== %s ========' % pod_lint_command)
    os.system(pod_lint_command)

# pod 发布
def pod_repo_push():
    if repo_name == '':
        # 发布到远端trunk仓库
        pod_push_command = 'pod trunk push %s %s %s %s --skip-import-validation' % (spec_name, allow_warnings, use_libraries, verbose)
        print('\n======== %s ========' % pod_push_command)
        os.system(pod_push_command)
    else:
        # 发布到远端私有仓库
        global sourcesStr
        if sourcesStr == '':
            sourcesStr = '--sources='+','.join(sources)
            pod_push_command = 'pod repo push %s %s %s %s %s %s --skip-import-validation' % (repo_name, spec_name, allow_warnings, use_libraries, verbose, sourcesStr)




# ========================================
#               程序启动入口
# ========================================

if __name__ == "__main__":

    #获取参数后，
    get_args()
    #如果需要拉取远端代码执行git pull命令
    if is_gitPull == True:
       get_gitRepoRemoteCode()
    #修改version，修改后，提交代码导git，然后发布
    edit_spec_version()
    edit_readme()
    # 如果自动更改版本号，则提交代码
    if auto_tag == '--auto' or auto_tag == '--auto-remove':
        commit_and_push_git()
    # 如果是指定版本tag，也需要提交代码
    if tag_version != '':
        commit_and_push_git()
    if is_release_push == True:
        pod_repo_push()
    else:
        pod_spc_lint()
