# java 高级

## 字节码

### ASM | 通过适配器读取生成字节码[文件]

https://blog.csdn.net/zhuoxiuwu/article/details/78619645

改写构造方法

```java
class ChangeToChildConstructorMethodAdapter extends MethodAdapter { 
    private String superClassName; 
 
    public ChangeToChildConstructorMethodAdapter(MethodVisitor mv, 
        String superClassName) { 
        super(mv); 
        this.superClassName = superClassName; 
    } 
 
    public void visitMethodInsn(int opcode, String owner, String name, 
        String desc) { 
        // 调用父类的构造函数时
        if (opcode == Opcodes.INVOKESPECIAL && name.equals("<init>")) { 
            owner = superClassName; 
        } 
        super.visitMethodInsn(opcode, owner, name, desc);// 改写父类为 superClassName 
    } 
}

```